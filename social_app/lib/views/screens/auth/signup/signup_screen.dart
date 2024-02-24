import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/views/screens/auth/widgets/auth_footer_signup.dart';
import 'package:social_app/views/screens/auth/widgets/auth_image_and_text.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const AuthImageAndText(),
              SizedBox(
                height: 0.72.sh,
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: AuthFooterSignup(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
