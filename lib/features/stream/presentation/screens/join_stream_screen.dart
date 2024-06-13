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

class JoinStreamScreen extends StatefulWidget {
  final UserModel? user;
  final String streamId;
  JoinStreamScreen({super.key, this.user, required this.streamId});

  @override
  State<JoinStreamScreen> createState() => _JoinStreamScreenState();
}

class _JoinStreamScreenState extends State<JoinStreamScreen> {
  @override
  void initState() {
    debugPrint('stream id for joining : ${widget.streamId}');
    debugPrint('stream id for joining : ${widget.user!.userId}');
    debugPrint('stream id for joining : ${widget.user!.fullName}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: LiveStreamConstants.zegocloud_APP_ID,
        appSign: LiveStreamConstants.zegocloud_APP_SIGN,
        userID: widget.user!.userId,
        userName: widget.user!.fullName,
        liveID: widget.streamId,
        events: ZegoUIKitPrebuiltLiveStreamingEvents(
          onLeaveConfirmation: (
            ZegoLiveStreamingLeaveConfirmationEvent event,
            Future<bool> Function() defaultAction,
          ) async {
            return await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.blue[900]!.withOpacity(0.9),
                  title: const Text(
                      "Are you sure want to leave this live stream ?",
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
        config: ZegoUIKitPrebuiltLiveStreamingConfig.audience()
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
