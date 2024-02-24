import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
enum SnackBarType { success, error, info }

class CustomSnackBar {

  static void showSuccessSnackBar(BuildContext context, {required String message,required SnackBarType snackBarType}) {
    AnimatedSnackBarType animatedSnackBarType;

    switch (snackBarType) {
      case SnackBarType.success:
        animatedSnackBarType = AnimatedSnackBarType.success;
        break;
      case SnackBarType.error:
        animatedSnackBarType = AnimatedSnackBarType.error;
        break;
      case SnackBarType.info:
        animatedSnackBarType = AnimatedSnackBarType.info;
        break;
    }
    AnimatedSnackBar.material(
      message,
      type: animatedSnackBarType,
      animationDuration:const Duration(milliseconds: 1400),
      duration:const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(10.r),
      snackBarStrategy: RemoveSnackBarStrategy()
    ).show(context);
  }
}
