import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Home/add_story.dart';
import 'package:social_app/views/screens/Home/home_store_card.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';

Widget homeStoryCards(BuildContext context) {
  return SizedBox(
    height: 90.h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: TextClass.titleText(
            "Feed",
            size: 18.sp,
            color: AppColors.darkBlack,
          ),
        ),
        SizedBox(
          height: 60.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddStoryScreen())),
                  child: const AddStoryCard()),
              const StoryCard(),
              const StoryCard(),
              const StoryCard(),
              const StoryCard(),
              // StoryCard(),
            ],
          ),
        ),
      ],
    ),
  );
}

class AddStoryCard extends StatelessWidget {
  const AddStoryCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tooltip(
        message: 'Add a new story',
        child: Container(
          height: 40.h,
          width: 40.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.buttonGradientOne,
                AppColors.buttonGradientTwo
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            size: 30.w,
            color: AppColors.darkBlack,
          ),
        ),
      ),
    );
  }
}
