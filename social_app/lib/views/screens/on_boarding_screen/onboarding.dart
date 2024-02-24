import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/utils/shared-preferences/shared_preferences.dart';
import 'package:social_app/utils/widgets/custom_button.dart';
import 'package:social_app/views/screens/auth/login/login_screen.dart';

class OnBoardignScreen extends StatelessWidget {
  const OnBoardignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 1.sh,
      width: 1.sw,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/boardingBackground.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //* image
          Image(
            image: const AssetImage(
              'assets/images/imageboarding.png',
            ),
            height: 350.w,
            width: 350.w,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 40.h,
          ),
          //* button
          CustomButton(
            width: 200.w,
            height: 50.h,
            backgroundColors: AppColors.gray.withOpacity(0.5),
            onPressed: () {
             AppSharedPreferences.setbool(
                    key: 'isShowenOnboarding', value: true)
                  .then(
                (value) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                ),
              );
            },
            buttontext: 'GET STARTED',
          )
        ],
      ),
    ));
  }
}
