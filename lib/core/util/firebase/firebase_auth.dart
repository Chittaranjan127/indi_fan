// Dart imports:
import 'dart:convert';
import 'dart:math';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:streamskit_mobile/core/util/SharedPreferencesUtil.dart';

// Project imports:
import 'package:streamskit_mobile/features/auth/domain/entities/social.dart';
import 'package:streamskit_mobile/features/home/data/model/user_model.dart';

import '../firestore/firestore_user.dart';

// Project imports:

Future<SocialValue?> signInWithGoogle() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FireStoreUser fireStoreUser = FireStoreUserImpl(firestore);

    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
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

    await fireStoreUser.saveUser(UserModel(userId: firebaseUserCredential.user!.uid, fullName: googleUser.displayName!, urlToImage: firebaseUserCredential.user!.photoURL!, email: firebaseUserCredential.user!.email!,  phoneNumber: firebaseUserCredential.user!.phoneNumber,));
    SharedPreferencesUtil.saveString('userId', firebaseUserCredential.user!.uid);

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
