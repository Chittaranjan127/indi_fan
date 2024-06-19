// Dart imports:
import 'dart:convert';
import 'dart:math';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:streamskit_mobile/core/util/SharedPreferencesUtil.dart';

// Project imports:
import 'package:streamskit_mobile/features/auth/domain/entities/social.dart';
import 'package:streamskit_mobile/features/home/data/model/user_model.dart';
import 'package:username_generator/username_generator.dart';

import '../firestore/firestore_user.dart';

// Project imports:

Future<SocialValue?> signInWithGoogle() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FireStoreUser fireStoreUser = FireStoreUserImpl(firestore);

    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
        'https://www.googleapis.com/auth/user.birthday.read'
      ]
    ).signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final OAuthCredential googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential firebaseUserCredential =
        await FirebaseAuth.instance.signInWithCredential(googleCredential);

    if (firebaseUserCredential.user == null) {
      return null;
    }

    // Request the user's profile information, including the birthday
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me?personFields=birthdays'),
      headers: await googleUser.authHeaders,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load profile information');
    }

    final Map<String, dynamic> profileData = json.decode(response.body);
    DateTime? birthday;
    if (profileData['birthdays'] != null && profileData['birthdays'].isNotEmpty) {
      final birthdayData = profileData['birthdays'].firstWhere((b) => b['date'] != null, orElse: () => null);
      if (birthdayData != null) {
        final date = birthdayData['date'];
        birthday = DateTime(date['year'], date['month'], date['day']);
      }
    }

    // Check if the user is 18 or older
    if (birthday != null) {
      final today = DateTime.now();
      final age = today.year - birthday.year - ((today.month < birthday.month || (today.month == birthday.month && today.day < birthday.day)) ? 1 : 0);
      if (age < 18) {
        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();
        throw Exception('User is under 18 years old');
      }
    }


    var generator = UsernameGenerator();
    String userName = generator.generate(googleUser.displayName!, date: birthday);
    await fireStoreUser.saveUser(UserModel(
      userId: firebaseUserCredential.user!.uid,
      fullName: googleUser.displayName!,
      userName: userName,
      displayPictureUrl: firebaseUserCredential.user!.photoURL!,
      email: firebaseUserCredential.user!.email!,
      phoneNumber: firebaseUserCredential.user!.phoneNumber,
      birthday: birthday,
    ));
    SharedPreferencesUtil.saveString('userId', firebaseUserCredential.user!.uid);
    SharedPreferencesUtil.saveString('userName', googleUser.displayName!);

    return SocialValue(
      fullName: googleUser.displayName ?? 'user.highbraintech.google',
      googleId: firebaseUserCredential.user!.uid,
    );
  } catch (e) {
    debugPrint('Exception while signInWithGoogle : $e');
    return null;
  }
}

Future<SocialValue?> signInWithFacebook({
  LoginBehavior behavior = LoginBehavior.nativeOnly,
}) async {
  try {
    await FacebookAuth.instance.logOut();
    // FacebookAuth.instance.expressLogin();
    final result = await FacebookAuth.instance.login(loginBehavior: behavior);

    switch (result.status) {
      case LoginStatus.success:
        final facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final firebaseUserCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        return SocialValue(
          fullName:
              firebaseUserCredential.user!.displayName ?? 'user.askany.fb',
          facebookId: firebaseUserCredential.user!.uid,
        );
      case LoginStatus.cancelled:
        return null;
      case LoginStatus.failed:
        break;
      default:
        break;
    }

    return signInWithFacebook(behavior: LoginBehavior.webOnly);
  } catch (error) {
    return null;
  }
}

Future<SocialValue?> signInWithApple() async {
  try {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    final UserCredential firebaseUserCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    if (firebaseUserCredential.user == null) {
      return null;
    }

    return SocialValue(
      fullName: appleCredential.givenName ?? 'user.askany.apple',
      appleId: firebaseUserCredential.user!.uid,
    );
  } catch (e) {
    return null;
  }
}

String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
