import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:streamskit_mobile/features/home/data/model/user_model.dart';

abstract class FireStoreUser {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUserById(String userId);
}

class FireStoreUserImpl implements FireStoreUser {
  final FirebaseFirestore _firestore;

  FireStoreUserImpl(this._firestore);

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.userId).set(user.toMap());
    } catch (e) {
      throw Exception('Error saving user: $e');
    }
  }

  @override
  Future<UserModel?> getUserById(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(userId).get();
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromMap(snapshot.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }
}
