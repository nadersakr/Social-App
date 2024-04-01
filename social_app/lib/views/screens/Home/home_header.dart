import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Home/add_post.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';

Widget homeHeader(BuildContext context) {
  return SizedBox(
    height: 110.h,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Socially',
                  style: TextStyle(
                      color: AppColors.darkBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddPostScreen()));
                    },
                    icon: const Icon(
                      EneftyIcons.notification_bold,
                      color: AppColors.darkBlack,
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: TextClass.titleText(
              "Feed",
              size: 18.sp,
              color: AppColors.darkBlack,
            ),
          )
        ],
      ),
    ),
  );
}
