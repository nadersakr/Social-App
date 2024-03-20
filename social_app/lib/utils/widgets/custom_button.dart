import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final Color? backgroundColors;
  const CustomButton(
      {super.key,
      this.buttonText,
      this.onPressed,
      this.height,
      this.width,
      this.backgroundColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: backgroundColors ?? AppColors.darkBlack,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          textAlign: TextAlign.center,
          buttonText ?? "Button",
          style: TextStyle(color: Colors.white, fontSize: 22.sp),
        ),
      ),
    );
  }
}
