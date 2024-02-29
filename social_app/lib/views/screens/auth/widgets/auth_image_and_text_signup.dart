import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/colors.dart';

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
      child: const Center(
        child: Text(
          'Welcome',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
