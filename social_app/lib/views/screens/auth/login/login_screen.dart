import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/views/screens/auth/widgets/auth_footer.dart';
import 'package:social_app/views/screens/auth/widgets/auth_image_and_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const AuthImageAndText(),
              Container(
                height: 0.6.sh,
                width: double.infinity,
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: AuthFooter(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
