// ignore_for_file: must_be_immutable

//add post provider

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Home/diffrence_time.dart';

class PostCard extends StatelessWidget {
  String? avatarImage;
  int? i;
  String? userName;
  String? postText;
  String? imageUrl;
  bool? isliked;
  String? time;
  VoidCallback? press;
  VoidCallback? navigateToAddcomment;
  VoidCallback? likeFunction;
  VoidCallback? commentFunction;
  int? likesNumber;
  int? commentsNumber;
  int? sharessNumber;
  PostCard(
      {super.key,
      this.avatarImage =
          'https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg',
      this.userName = "User Name",
      required this.postText,
      required this.i,
      this.imageUrl,
      this.likeFunction,
      this.navigateToAddcomment,
      this.commentFunction,
      this.press,
      this.likesNumber = 0,
      this.commentsNumber = 0,
      this.sharessNumber = 0,
      this.isliked,
      required this.time});

  @override
  Widget build(BuildContext context) {
    final postController = Provider.of<PostController>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.blue.withOpacity(0.3)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 10.h,
            left: 26.w,
            child: Selector<PostController, bool>(
              selector: (context, postController) {
                if (postController.posts[i!]['isLiked'] != null) {
                  return postController.posts[i!]['isLiked'];
                } else {
                  return false;
                }
              },
              builder: (context, liked, child) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: likeFunction,
                      child: customContainer(
                          active: liked,
                          activeIcon: EneftyIcons.heart_bold,
                          EneftyIcons.heart_outline,
                          "${postController.posts[i!]['likers']?.length ?? 0}"),
                    ),
                    SizedBox(width: 32.w),
                    GestureDetector(
                      onTap: navigateToAddcomment,
                      child: customContainer(
                          EneftyIcons.message_text_outline, "$commentsNumber"),
                    ),
                    SizedBox(width: 32.w),
                    GestureDetector(
                      onTap: navigateToAddcomment,
                      child: customContainer(
                          EneftyIcons.archive_tick_outline, "$commentsNumber"),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: press,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          avatarImage ??
                              'https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName ?? 'User Name',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.white),
                          ),
                          Text(
                            getDifferenceFromNow(time!) ?? '00',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: navigateToAddcomment,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget customContainer(IconData unActiveIcon, String text,
    {Color? color, bool? active, IconData? activeIcon}) {
  return Container(
    height: 21.h,
    width: 70.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      color: Colors.grey.shade500.withOpacity(0.4),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          (active ?? false) ? (activeIcon ?? Icons.add) : unActiveIcon,
          size: 16.w,
          color: (active ?? false) ? (AppColors.red) : AppColors.white,
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
      ],
    ),
  );
}
