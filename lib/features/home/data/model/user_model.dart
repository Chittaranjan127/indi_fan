// ignore_for_file: public_member_api_docs, sort_constructors_first

// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

import 'dart:convert';

import 'dart:convert';

enum Gender {
  male,
  female,
  other,
}

class UserModel {
  String userId;
  String fullName;
  String urlToImage;
  String email;
  String? description;
  String? phoneNumber;
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

  UserModel({
    required this.userId,
    required this.fullName,
    required this.urlToImage,
    required this.email,
    this.description,
    this.phoneNumber,
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
  });

  UserModel copyWith({
    String? userId,
    String? fullName,
    String? urlToImage,
    String? description,
    String? phoneNumber,
    Gender? gender,
    DateTime? birthday,
    int? posts,
    int? followings,
    int? followers,
    List<String>? listFields,
    bool? isLiveStream,
    bool? isHost,
    bool? isVerified,
    int? totalViews,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      urlToImage: urlToImage ?? this.urlToImage,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      posts: posts ?? this.posts,
      followings: followings ?? this.followings,
      followers: followers ?? this.followers,
      listFields: listFields ?? this.listFields,
      isLiveStream: isLiveStream ?? this.isLiveStream,
      isHost: isHost ?? this.isHost,
      isVerified: isVerified ?? this.isVerified,
      totalViews: totalViews ?? this.totalViews,
      email: email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'urlToImage': urlToImage,
      'description': description,
      'phoneNumber': phoneNumber,
      'gender': gender.index,
      'birthday': birthday?.millisecondsSinceEpoch,
      'posts': posts,
      'followings': followings,
      'followers': followers,
      'listFields': listFields,
      'isLiveStream': isLiveStream,
      'isHost': isHost,
      'isVerified': isVerified,
      'totalViews': totalViews,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      description: map['description'],
      phoneNumber: map['phoneNumber'],
      gender: Gender.values[map['gender'] ?? 2], // Assuming default to 'other'
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthday'])
          : null,
      posts: map['posts']?.toInt(),
      followings: map['followings']?.toInt(),
      followers: map['followers']?.toInt(),
      listFields: List<String>.from(map['listFields']),
      isLiveStream: map['isLiveStream'] ?? false,
      isHost: map['isHost'] ?? false,
      isVerified: map['isVerified'] ?? false,
      totalViews: map['totalViews']?.toInt(),
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, fullName: $fullName, urlToImage: $urlToImage, description: $description, phoneNumber: $phoneNumber, gender: $gender, birthday: $birthday, posts: $posts, followings: $followings, followers: $followers, listFields: $listFields, isLiveStream: $isLiveStream, isHost: $isHost, isVerified: $isVerified, totalViews: $totalViews)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.fullName == fullName &&
        other.urlToImage == urlToImage &&
        other.description == description &&
        other.phoneNumber == phoneNumber &&
        other.gender == gender &&
        other.birthday == birthday &&
        other.posts == posts &&
        other.followings == followings &&
        other.followers == followers &&
        listEquals(other.listFields, listFields) &&
        other.isLiveStream == isLiveStream &&
        other.isHost == isHost &&
        other.isVerified == isVerified &&
        other.totalViews == totalViews;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
    fullName.hashCode ^
    urlToImage.hashCode ^
    description.hashCode ^
    phoneNumber.hashCode ^
    gender.hashCode ^
    birthday.hashCode ^
    posts.hashCode ^
    followings.hashCode ^
    followers.hashCode ^
    listFields.hashCode ^
    isLiveStream.hashCode ^
    isHost.hashCode ^
    isVerified.hashCode ^
    totalViews.hashCode;
  }
}


List<UserModel> listUserFake = [
  UserModel(fullName: 'Brody', urlToImage: urlUserFake3, isLiveStream: true, userId: 'ksbjbwejfbew', email: ''),
  UserModel(fullName: 'Johnny', urlToImage: urlUserFake2, userId: 'ioqwfiohqfop', email: ''),
  UserModel(fullName: 'Caroline', urlToImage: urlUserFake, userId: 'eoifhioew', email: ''),
  UserModel(fullName: 'Jerry', urlToImage: urlUserFake2, userId: 'op23uoewhjfg', email: ''),
  UserModel(fullName: 'Tommy', urlToImage: urlUserFake, userId: 'iohwefiohwef', email: ''),
  UserModel(fullName: 'Cris', urlToImage: urlUserFake2, userId: 'oiwehgiwehg', email: ''),
];

const urlUserFake =
    'https://images.unsplash.com/photo-1559969143-b2defc6419fd?ixlib=rb-1.2.1&ixuserId=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Z2FtZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60';
const urlUserFake2 =
    'https://images.unsplash.com/photo-1534488972407-5a4aa1e47d83?ixlib=rb-1.2.1&ixuserId=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Z2FtZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60';
const urlUserFake3 =
    'https://images.unsplash.com/photo-1610041321420-a596dd14ebc9?ixlib=rb-1.2.1&ixuserId=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGdhbWVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60';
