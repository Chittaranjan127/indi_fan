// ignore_for_file: public_member_api_docs, sort_constructors_first

// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

import 'dart:convert';

import 'dart:convert';

import 'dart:convert';

import 'dart:convert';

enum Gender {
  male,
  female,
  other,
}

abstract class Model {
  Map<String, dynamic> toMap();
  String toJson() => json.encode(toMap());
}

class UserModel implements Model {
  String userId;
  String fullName;
  String userName;
  String displayPictureUrl;
  String email;
  String? description;
  String? phoneNumber;
  String? bio;
  Gender gender;
  DateTime? birthday;
  int? posts;
  int? followings;
  int? followers;
  List<String>? listFields;
  bool isLiveStream;
  bool isHost;
  bool isVerified;
  int? totalViews;
  String? platformId;

  UserModel({
    required this.userId,
    required this.fullName,
    required this.userName,
    required this.displayPictureUrl,
    required this.email,
    this.description,
    this.phoneNumber,
    this.bio,
    this.gender = Gender.other,
    this.birthday,
    this.posts,
    this.followings,
    this.followers,
    this.listFields,
    this.isLiveStream = false,
    this.isHost = false,
    this.isVerified = false,
    this.totalViews,
    this.platformId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'userName': userName,
      'displayPictureUrl': displayPictureUrl,
      'email': email,
      'description': description,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'gender': gender.index,
      'birthday': birthday?.millisecondsSinceEpoch,
      'posts': posts,
      'followings': followings,
      'followers': followers,
      'listFields': listFields ?? [],
      'isLiveStream': isLiveStream,
      'isHost': isHost,
      'isVerified': isVerified,
      'totalViews': totalViews,
      'platformId': platformId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      userName: map['userName'] ?? '',
      displayPictureUrl: map['displayPictureUrl'] ?? '',
      email: map['email'] ?? '',
      description: map['description'],
      phoneNumber: map['phoneNumber'],
      bio: map['bio'],
      gender: Gender.values[map['gender'] ?? 2],
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthday'])
          : null,
      posts: map['posts']?.toInt(),
      followings: map['followings']?.toInt(),
      followers: map['followers']?.toInt(),
      listFields: map['listFields'] != null ? List<String>.from(map['listFields']) : [],
      isLiveStream: map['isLiveStream'] ?? false,
      isHost: map['isHost'] ?? false,
      isVerified: map['isVerified'] ?? false,
      totalViews: map['totalViews']?.toInt(),
      platformId: map['platformId'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, fullName: $fullName, userName: $userName, displayPictureUrl: $displayPictureUrl, description: $description, phoneNumber: $phoneNumber, bio: $bio, gender: $gender, birthday: $birthday, posts: $posts, followings: $followings, followers: $followers, listFields: $listFields, isLiveStream: $isLiveStream, isHost: $isHost, isVerified: $isVerified, totalViews: $totalViews, platformId: $platformId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.fullName == fullName &&
        other.userName == userName &&
        other.displayPictureUrl == displayPictureUrl &&
        other.description == description &&
        other.phoneNumber == phoneNumber &&
        other.bio == bio &&
        other.gender == gender &&
        other.birthday == birthday &&
        other.posts == posts &&
        other.followings == followings &&
        other.followers == followers &&
        listEquals(other.listFields, listFields) &&
        other.isLiveStream == isLiveStream &&
        other.isHost == isHost &&
        other.isVerified == isVerified &&
        other.totalViews == totalViews &&
        other.platformId == platformId;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
    fullName.hashCode ^
    userName.hashCode ^
    displayPictureUrl.hashCode ^
    description.hashCode ^
    phoneNumber.hashCode ^
    bio.hashCode ^
    gender.hashCode ^
    birthday.hashCode ^
    posts.hashCode ^
    followings.hashCode ^
    followers.hashCode ^
    listFields.hashCode ^
    isLiveStream.hashCode ^
    isHost.hashCode ^
    isVerified.hashCode ^
    totalViews.hashCode ^
    platformId.hashCode;
  }
}


List<UserModel> listUserFake = [
  UserModel(fullName: 'Brody',  isLiveStream: true, userId: 'ksbjbwejfbew', email: '', userName: '', displayPictureUrl: ''),
  UserModel(fullName: 'Johnny',  userId: 'ioqwfiohqfop', email: '', userName: '', displayPictureUrl: ''),
  UserModel(fullName: 'Caroline', userId: 'eoifhioew', email: '', userName: '', displayPictureUrl: ''),
  UserModel(fullName: 'Jerry', userId: 'op23uoewhjfg', email: '', userName: '', displayPictureUrl: ''),
  UserModel(fullName: 'Tommy', userId: 'iohwefiohwef', email: '', userName: '', displayPictureUrl: ''),
  UserModel(fullName: 'Cris', userId: 'oiwehgiwehg', email: '', userName: '', displayPictureUrl: ''),
];

const urlUserFake =
    'https://images.unsplash.com/photo-1559969143-b2defc6419fd?ixlib=rb-1.2.1&ixuserId=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Z2FtZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60';
const urlUserFake2 =
    'https://images.unsplash.com/photo-1534488972407-5a4aa1e47d83?ixlib=rb-1.2.1&ixuserId=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Z2FtZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60';
const urlUserFake3 =
    'https://images.unsplash.com/photo-1610041321420-a596dd14ebc9?ixlib=rb-1.2.1&ixuserId=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGdhbWVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60';
