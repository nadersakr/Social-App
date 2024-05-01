import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/utils/widgets/custom_button.dart';
import 'package:social_app/view_model/login_viewmodel.dart';
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
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    var authController = Provider.of<AuthController>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SvgPicture.asset(
              loginViewModel.svg,
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(loginViewModel.heightScreen_20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: loginViewModel.heightSpace_150),
                    Align(
                      alignment: Alignment.center,
                      child: TextClass(
                          text: loginViewModel.doYouHaveAccountString,
                          color: Colors.black),
                    ),
                    SizedBox(height: loginViewModel.heightSpace_30),
                    Form(
                      key: authController.formKeyLogin,
                      child: Column(
                        children: [
                          CustomTextField(
                            suffixIcon: const Icon(EneftyIcons.user_outline),
                            controller: authController.mailLoginController,
                            hintText: loginViewModel.emailString,
                            keyboardType: TextInputType.emailAddress,
                            validator: Tvalidator.emailvalidator,
                          ),
                          SizedBox(height: loginViewModel.heightScreen_20),
                          CustomTextField(
                            controller: authController.passwordLoginController,
                            hintText: loginViewModel.passwordString,
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
                          SizedBox(height: loginViewModel.heightScreen_20),
                          InkWell(
                            onTap: () async {
                              // Your forgot password logic here
                            },
                            child: Text(
                              loginViewModel.forgetPasswordString,
                              style: TextStyle(
                                fontSize: loginViewModel.smallFont,
                                color: AppColors.darkBlack,
                              ),
                            ),
                          ),
                          SizedBox(height: loginViewModel.heightSpace_30),
                          CustomButton(
                            buttonText: loginViewModel.loginString,
                            onPressed: () async {
                              await LoginFunctions.loginFunction(
                                  authController, context);
                            },
                          ),
                          SizedBox(height: loginViewModel.heightSpace_30),
                          TextRow(
                            text: loginViewModel.doYouHaveAccountString,
                            textButton: loginViewModel.signUpString,
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
