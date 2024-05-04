import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';
import 'package:social_app/views/screens/chat/chat_screen.dart';

class ChatKit extends StatelessWidget {
  final String lastMessage;
  final String time;
  final MainUser friend;
  const ChatKit(
      {super.key,
      required this.friend,
      required this.lastMessage,
      required this.time});

  @override
  Widget build(BuildContext context) {
    // String formattedTime = DateFormat('jm').format(DateTime.parse(time));
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(resevier: friend),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(38.r),
        ),
        // height: 90.h,
        width: 1.sw - 48.w,
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.darkBlack,
                    width: 2.w,
                  ),
                ),
                child: CircleAvatar(
                  radius: 34.r,
                  backgroundImage: NetworkImage(friend.avatar),
                )),
            SizedBox(
              width: 21.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextClass(
                  text:
                      "${(friend.userName ?? 'User Name').substring(0, 1).toUpperCase()}${(friend.userName ?? 'User Name').substring(1)}",
                  color: AppColors.darkBlack,
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextClass(
                  text: lastMessage,
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
