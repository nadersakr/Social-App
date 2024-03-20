import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Home/AddStory.dart';

Widget homeStoryCards(BuildContext context) {
  return SizedBox(
    height: 100,
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
            child: const addStoryCard()),
        // StoryCard(),
        // StoryCard(),
      ],
    ),
  );
}

class addStoryCard extends StatelessWidget {
  const addStoryCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tooltip(
        message: 'Add a new story',
        child: Container(
          height: 50.h,
          width: 50.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.blue.withOpacity(0.4), AppColors.blue],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
