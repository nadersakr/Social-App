import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/utils/widgets/animation_navigat_screen.dart';
import 'package:social_app/utils/widgets/custom_button.dart';
import 'package:social_app/utils/widgets/custom_snack_bar.dart';
import 'package:social_app/views/reusable_components_widgets/validators.dart';
import 'package:social_app/views/screens/auth/signup/signup_screen.dart';
import 'package:social_app/views/screens/auth/widgets/auth_image_and_text.dart';
import 'package:social_app/views/screens/auth/widgets/custom_text_field.dart';
import 'package:social_app/views/screens/auth/widgets/login_logic_operations.dart';
import 'package:social_app/views/screens/auth/widgets/text_row.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/Authentication Background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/images/your_logo.png', // Provide your logo image path
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 150.h), // Adjust the height as needed
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'YourCustomFont', // Use your custom font
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    Form(
                      key: authController.formKeyLogin,
                      child: Column(
                        children: [
                          CustomTextField(
                            suffixIcon: const Icon(Icons.person),
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
                                  ? Icons.visibility
                                  : Icons.visibility_off),
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
                              'FORGOT PASSWORD',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.blue,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          CustomButton(
                            buttonText: "LogIN",
                            onPressed: () async {
                              await LoginFunctions.LoginFunction(
                                  authController, context);
                            },
                          ),
                          SizedBox(height: 30.h),
                          TextRow(
                            text: 'Don\'t have an account?',
                            textButton: "SignUp",
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                AnimationNavigatScreen(const SignupScreen()),
                              );
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
