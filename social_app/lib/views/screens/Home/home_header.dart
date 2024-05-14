import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Search/search.dart';

Widget homeHeader(BuildContext context) {
  return SizedBox(
    height: 55.h,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                    // navigate to search screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                  },
                  icon: const Icon(
                    EneftyIcons.search_normal_outline,
                    color: AppColors.darkBlack,
                  ))
            ],
          ),
        ],
      ),
    ),
  );
}
