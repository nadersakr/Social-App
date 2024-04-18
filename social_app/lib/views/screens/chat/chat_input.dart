import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final Function(String) onSend;

  ChatInput({super.key, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Container(
        height: 75.h,
        width: 1.sw - 40.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  style: TextStyle(fontSize: 14.sp),
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Write a message',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write a message';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {},
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (controller.text.trim().isNotEmpty) {
                    onSend(controller.text);
                    controller.clear();
                  }
                },
                child: SvgPicture.asset("assets/svg/chatsInputIcon.svg",
                    fit: BoxFit.fill),
              ),
            ],
          ),
        ),
      ),
    );
  }
}