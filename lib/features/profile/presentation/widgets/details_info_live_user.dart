// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

// Project imports:
import 'package:streamskit_mobile/core/network/url_launcher_helper.dart';
import 'package:streamskit_mobile/core/util/common/touchable_opacity.dart';
import 'package:streamskit_mobile/core/util/custom_image/custom_netword_image.dart';
import 'package:streamskit_mobile/core/util/sizer_custom/sizer.dart';
import 'package:streamskit_mobile/core/util/styles/profile_style.dart';
import 'package:streamskit_mobile/features/home/data/model/user_model.dart';
import 'package:streamskit_mobile/features/profile/presentation/widgets/index_info_user.dart';

class DetailInfoLiveUserWidget extends StatefulWidget {
  final UserModel user;
  const DetailInfoLiveUserWidget({
    super.key,
    required this.user,
  });

  @override
  State<DetailInfoLiveUserWidget> createState() =>
      _DetailInfoLiveUserWidgetState();
}

class _DetailInfoLiveUserWidgetState extends State<DetailInfoLiveUserWidget> {
  bool isFollowing = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 25.sp),
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: CustomNetworkImage(
                    urlToImage:
                        "https://i.pinimg.com/originals/ca/33/57/ca335747b1f2b5b8611be00eb1307105.jpg",
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16.sp),
                    width: 150.w,
                    height: 150.sp,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 80.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.sp,
                            bottom: 2.sp,
                          ),
                          child: Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: 80.w),
                                child: Text(
                                  widget.user.fullName,
                                  style: text13mCL,
                                ),
                              ),
                              SizedBox(width: 2.sp),
                              Icon(
                                PhosphorIcons.circle_wavy_check_fill,
                                size: 13.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "@tonytonychopper",
                          style: text9mCL,
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(height: 5.sp),
              ],
            ),
            Positioned(
              left: 5.sp,
              bottom: 0.sp,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 8,
                    color: Colors.black,
                  ),
                ),
                child: CustomNetworkImage(
                  urlToImage: widget.user.displayPictureUrl,
                  height: 60.sp,
                  width: 60.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
          child: Linkify(
            onOpen: (link) async {
              UrlLauncherHelper.launchUrlString(Uri.parse(link.url));
            },
            text: widget.user.description!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: text9mCL,
            linkStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(height: 5.sp),
      ],
    );
  }
}
