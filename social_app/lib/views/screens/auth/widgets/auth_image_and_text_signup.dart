import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';

class AuthImageAndTextSignUp extends StatelessWidget {
  const AuthImageAndTextSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.1.sh,
      width: double.infinity,
      color: AppColors.blue,
      child: Center(
        child: customSubText("Sign Up", color: Colors.black),
      ),
    );
  }
}
