import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/utils/shared-preferences/shared_preferences.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';
import 'package:social_app/views/screens/auth/login/login_screen.dart';

class OnBoardignScreen extends StatefulWidget {
  const OnBoardignScreen({super.key});

  @override
  State<OnBoardignScreen> createState() => _OnBoardignScreenState();
}

class _OnBoardignScreenState extends State<OnBoardignScreen> {
  final List<String> images = [
    'assets/images/3.png',
    'assets/images/2.png',
    'assets/images/1.png',
  ];

  final List<String> descriptions = [
    'Socially is a social media platform.',
    'Message your friends and stay connected with them...',
    'Share your moments in your Story..'
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: Stack(
        children: [
          SvgPicture.asset("assets/svg/1.svg"),
          Positioned(
            top: 60.h,
            left: (1.sw / 2) - 65,
            child: const Center(
              child: TextClass(text: 'Welcome to'),
            ),
          ),
          Positioned(
            top: 80.h,
            left: (1.sw / 2) - 75,
            child: Center(
              child: TextClass.titleText('Socially'),
            ),
          ),
          PageView.builder(
              itemCount: 3,
              onPageChanged: (vale) {
                setState(() {
                  currentIndex = vale;
                });
              },
              itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120.h,
                      ),
                      Image(
                        image: AssetImage(images[index]),
                        width: 300.w,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.h),
                        child: TextClass(text: descriptions[index]),
                      ),
                      SizedBox(
                        height: 200.h,
                      ),
                    ],
                  )),
          Positioned(
            child: indecator(index: currentIndex),
            bottom: 190.h,
            left: 0.45.sw,
          ),
          GestureDetector(
            onTap: () {
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
            child: Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset('assets/svg/button.svg'),
            ),
          )
        ],
      ),
    ));
  }
}

indecator({int? index}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      3,
      (i) => Container(
        margin: const EdgeInsets.only(right: 5),
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.darkBlack,
            width: 1,
          ),
          color: index == i ? AppColors.darkBlack : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
