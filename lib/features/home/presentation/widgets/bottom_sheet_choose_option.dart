// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:streamskit_mobile/core/app/colors/app_color.dart';
import 'package:streamskit_mobile/core/navigator/app_pages.dart';
import 'package:streamskit_mobile/core/navigator/app_routes.dart';
import 'package:streamskit_mobile/core/util/logger.dart';
import 'package:streamskit_mobile/core/util/sizer_custom/sizer.dart';
import 'package:streamskit_mobile/core/util/styles/profile_style.dart';
import 'package:streamskit_mobile/features/profile/presentation/widgets/row_icon_text.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/user_model.dart';
import '../../../stream/presentation/screens/stream_screen.dart';

class BottomSheetChooseOptionHome extends StatelessWidget {
  final UserModel user;
  final Uuid _uuid = Uuid();
  BottomSheetChooseOptionHome({super.key, required this.user});

  void _startLiveStream(BuildContext context) {
    UtilLogger.log('inside _startLiveStream');
    String streamId = _uuid.v4();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StreamScreen(
          user: user,
          streamId: streamId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp).add(
        EdgeInsets.only(bottom: 10.sp),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.sp),
        ),
        color: Colors.grey.shade900,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DividerBottomSheet(),
          SizedBox(
            height: 8.sp,
          ),
          RowIconText(
            title: "Start Instant Live Stream",
            iconLeading: Icons.live_tv_outlined,
            onTap: () {
              _startLiveStream(context);
            },
          ),
          Divider(
            thickness: 0.2,
            color: mCU,
          ),
          RowIconText(
            title: "Schedule Live Stream",
            iconLeading: Icons.timer,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class DividerBottomSheet extends StatelessWidget {
  const DividerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 3.sp,
        width: 60.sp,
        decoration: BoxDecoration(
          color: colorDividerBottomSheetDark,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
