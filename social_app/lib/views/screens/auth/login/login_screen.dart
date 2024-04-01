import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/utils/widgets/custom_button.dart';
import 'package:social_app/views/reusable_components_widgets/validators.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';
import 'package:social_app/views/screens/auth/signup/signup_screen.dart';
import 'package:social_app/views/screens/auth/widgets/custom_text_field.dart';
import 'package:social_app/views/screens/auth/widgets/login_logic_operations.dart';
import 'package:social_app/views/screens/auth/widgets/text_row.dart';
import 'package:enefty_icons/enefty_icons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SvgPicture.asset('assets/svg/1.svg'),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 150.h),
                    const Align(
                      alignment: Alignment.center,
                      child: TextClass(
                          text: 'Login to your account', color: Colors.black),
                    ),
                    SizedBox(height: 30.h),
                    Form(
                      key: authController.formKeyLogin,
                      child: Column(
                        children: [
                          CustomTextField(
                            suffixIcon: const Icon(EneftyIcons.user_outline),
                            controller: authController.mailLoginController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: Tvalidator.emailvalidator,
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            controller: authController.passwordLoginController,
                            hintText: 'Password',
                            obscureText: authController.isobscureText,
                            suffixIcon: InkWell(
                              onTap: authController.visibility,
                              child: Icon(authController.isobscureText
                                  ? EneftyIcons.password_check_outline
                                  : EneftyIcons.password_check_bold),
                            ),
                            keyboardType: TextInputType.text,
                            validator: Tvalidator.passwordValidator,
                          ),
                          SizedBox(height: 25.h),
                          InkWell(
                            onTap: () async {
                              // Your forgot password logic here
                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.darkBlack,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          CustomButton(
                            buttonText: "Login",
                            onPressed: () async {
                              await LoginFunctions.loginFunction(
                                  authController, context);
                            },
                          ),
                          SizedBox(height: 30.h),
                          TextRow(
                            text: 'Don\'t have an account?',
                            textButton: "SignUp",
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const SignupScreen(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = const Offset(0.0, 1.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                                transitionDuration: const Duration(
                                    milliseconds:
                                        500), // Add your desired duration here
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
