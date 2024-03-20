import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/views/screens/auth/widgets/auth_image_and_text.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            // const AuthImageAndText(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 0.73.sh,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child:  const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: ResetPasswordScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
