import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LiveStreamModel {
  String streamId;
  String userId;
  String hostName;
  String hostImageUrl;
  DateTime startTime;
  bool isLiveStreamEnded;
  DateTime? endTime;
  int views;
  int audienceCount;
  double watchHours;
  double totalRevenue;

  LiveStreamModel({
    required this.streamId,
    required this.userId,
    required this.hostName,
    required this.hostImageUrl,
    required this.startTime,
    this.isLiveStreamEnded = false,
    this.endTime,
    this.views = 0,
    this.audienceCount = 0,
    this.watchHours = 0.0,
    this.totalRevenue = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'streamId': streamId,
      'userId': userId,
      'hostName': hostName,
      'hostImageUrl': hostImageUrl,
      'startTime': startTime.millisecondsSinceEpoch,
      'isLiveStreamEnded': isLiveStreamEnded,
      'endTime': endTime?.millisecondsSinceEpoch,
      'views': views,
      'audienceCount': audienceCount,
      'watchHours': watchHours,
      'totalRevenue': totalRevenue,
    };
  }

  factory LiveStreamModel.fromMap(Map<String, dynamic> map) {
    return LiveStreamModel(
      streamId: map['streamId'] ?? '',
      userId: map['userId'] ?? '',
      hostName: map['hostName'] ?? '',
      hostImageUrl: map['hostImageUrl'] ?? '',
      startTime: (map['startTime'] as Timestamp).toDate(),
      isLiveStreamEnded: map['isLiveStreamEnded'] ?? false,
      endTime: map['endTime'] != null
          ? (map['endTime'] as Timestamp).toDate()
          : null,
      views: map['views']?.toInt() ?? 0,
      audienceCount: map['audienceCount']?.toInt() ?? 0,
      watchHours: map['watchHours']?.toDouble() ?? 0.0,
      totalRevenue: map['totalRevenue']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveStreamModel.fromJson(String source) =>
      LiveStreamModel.fromMap(json.decode(source));
}
