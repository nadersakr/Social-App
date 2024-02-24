import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthImageAndText extends StatelessWidget {
  const AuthImageAndText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.3.sh,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Authentication Background.png'),
          fit: BoxFit.fill,
        ),
      ),
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
