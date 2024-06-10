import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:streamskit_mobile/core/app/constant/LiveStreamConstants.dart';

// Project imports:
import 'package:streamskit_mobile/core/util/sizer_custom/sizer.dart';
import 'package:streamskit_mobile/features/stream/presentation/widgets/app_bar_stream.dart';
import 'package:streamskit_mobile/features/stream/presentation/widgets/comment_widget.dart';
import 'package:streamskit_mobile/features/stream/provider/hearts_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

import '../../../home/data/model/live_stream_model.dart';
import '../../../home/data/model/user_model.dart';

class StreamScreen extends StatefulWidget {
  final UserModel user;
  final String streamId;
  StreamScreen({super.key, required this.user, required this.streamId});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    _insertLiveStreamData();
  }

  Future<void> _insertLiveStreamData() async {
    LiveStreamModel liveStream = LiveStreamModel(
      streamId: widget.streamId,
      userId: widget.user.userId,
      hostName: widget.user.fullName,
      hostImageUrl: widget.user.urlToImage,
      startTime: DateTime.now(),
      isLiveStreamEnded: false,
      endTime: null,
      views: 0,
      audienceCount: 0,
      watchHours: 0.0,
      totalRevenue: 0.0,
    );

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('liveStreams')
        .doc(widget.streamId)
        .set(liveStream.toMap());
  }

  Future<void> _updateLiveStreamData() async {
    DateTime endTime = DateTime.now();
    Duration duration = endTime.difference(startTime);

    ZegoUIKitPrebuiltLiveStreaming liveStreamData =
        await ZegoUIKitPrebuiltLiveStreaming(
      appID: LiveStreamConstants.zegocloud_APP_ID,
      appSign: LiveStreamConstants.zegocloud_APP_SIGN,
      userID: widget.user.userId,
      userName: widget.user.fullName,
      liveID: widget.streamId,
      config: ZegoUIKitPrebuiltLiveStreamingConfig.host(),
    );

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: LiveStreamConstants.zegocloud_APP_ID,
        appSign: LiveStreamConstants.zegocloud_APP_SIGN,
        userID: widget.user.userId,
        userName: widget.user.fullName,
        liveID: widget.streamId,
        events: ZegoUIKitPrebuiltLiveStreamingEvents(
          onLeaveConfirmation: (
            ZegoLiveStreamingLeaveConfirmationEvent event,

            /// defaultAction to return to the previous page
            Future<bool> Function() defaultAction,
          ) async {
            return await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.blue[900]!.withOpacity(0.9),
                  title: const Text(
                      "Are you sure want to end this live stream ?",
                      style: TextStyle(color: Colors.white70)),
                  actions: [
                    ElevatedButton(
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.white70)),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    ElevatedButton(
                      child: const Text("Exit"),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                );
              },
            );
          },
        ),
        config: ZegoUIKitPrebuiltLiveStreamingConfig.host()
          ..avatarBuilder = (BuildContext context, Size size,
              ZegoUIKitUser? user, Map extraInfo) {
            return user != null
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/avatar.jpeg")),
                    ),
                  )
                : const SizedBox();
          },
      ),
    );
  }
}
