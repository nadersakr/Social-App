import 'package:flutter/material.dart';
import 'package:social_app/views/screens/auth/widgets/auth_footer_signup.dart';
import 'package:social_app/views/screens/auth/widgets/auth_image_and_text_signup.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              AuthImageAndTextSignUp(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: AuthFooterSignup(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
