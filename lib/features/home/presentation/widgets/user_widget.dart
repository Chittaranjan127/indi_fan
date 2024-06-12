// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:streamskit_mobile/core/app/colors/app_color.dart';
import 'package:streamskit_mobile/core/util/custom_image/custom_netword_image.dart';
import 'package:streamskit_mobile/core/util/sizer_custom/sizer.dart';
import 'package:streamskit_mobile/features/home/data/model/live_stream_model.dart';
import 'package:streamskit_mobile/features/home/data/model/user_model.dart';

class UserWidget extends StatelessWidget {
  final LiveStreamModel liveStreamModel;

  const UserWidget({super.key, required this.liveStreamModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 8.sp),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(3.5.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.2.sp,
                    color: liveStreamModel.isLiveStreamEnded
                        ? colorBlack2
                        : colorPink,
                  ),
                ),
                child: CustomNetworkImage(
                  height: 42.sp,
                  width: 42.sp,
                  urlToImage: liveStreamModel.hostImageUrl,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 6.sp),
            ],
          ),
        ),
        Visibility(
          visible: liveStreamModel.isLiveStreamEnded ? false : true,
          child: Positioned(
            right: 15,
            child: Container(
              padding: const EdgeInsets.only(
                left: 1,
                bottom: 1,
                right: 1,
              ),
              alignment: Alignment.center,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 9.sp),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Text(
                  'Live',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 7.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
