// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project imports:
import 'package:streamskit_mobile/core/util/sizer_custom/sizer.dart';
import 'package:streamskit_mobile/core/util/styles/style.dart';
import 'package:streamskit_mobile/features/home/presentation/widgets/button_circle.dart';
import 'package:streamskit_mobile/features/home/presentation/widgets/list_category_home.dart';
import 'package:streamskit_mobile/features/home/presentation/widgets/list_user_follow.dart';

AppBar appBarHome({
  required BuildContext context,
}) {
  return AppBar(
    // toolbarHeight: 40.sp,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.transparent,
    surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
    elevation: 0.0,
    automaticallyImplyLeading: false,
    centerTitle: true,
    actions: [
      Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              launcherIcon,
              height: 44.sp,
              width: 44.sp,
              fit: BoxFit.cover,
            ),
            // Row(
            //   children: [
            //     ButtonCircle(
            //       icon: PhosphorIcons.moonLight,
            //       onTap: () {},
            //     ),
            //     SizedBox(width: 8.sp),
            //     ButtonCircle(
            //       icon: PhosphorIcons.bellLight,
            //       onTap: () {},
            //     ),
            //     SizedBox(width: 8.sp),
            //     ButtonCircle(
            //       icon: PhosphorIcons.magnifyingGlassLight,
            //       onTap: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    ],
  );
}
