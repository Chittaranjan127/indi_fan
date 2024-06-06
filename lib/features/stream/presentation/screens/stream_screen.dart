import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:streamskit_mobile/core/app/constant/LiveStreamConstants.dart';

// Project imports:
import 'package:streamskit_mobile/core/util/sizer_custom/sizer.dart';
import 'package:streamskit_mobile/features/stream/presentation/widgets/app_bar_stream.dart';
import 'package:streamskit_mobile/features/stream/presentation/widgets/comment_widget.dart';
import 'package:streamskit_mobile/features/stream/provider/hearts_provider.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: LiveStreamConstants.zegocloud_APP_ID,
        appSign: LiveStreamConstants.zegocloud_APP_SIGN,
        userID: 'user_id',
        userName: 'user_name',
        liveID: LiveStreamConstants.zegocloud_LIVE_ID,
        config: ZegoUIKitPrebuiltLiveStreamingConfig.host()
          ..avatarBuilder = (BuildContext context, Size size,
              ZegoUIKitUser? user, Map extraInfo) {
            return user != null
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg',
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          },
      ),
    );
  }
}
