import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/utils/widgets/custom_button.dart';
import 'package:social_app/view_model/login_viewmodel.dart';
import 'package:social_app/views/reusable_components_widgets/validators.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';
import 'package:social_app/views/screens/auth/signup/signup_screen.dart';
import 'package:social_app/views/screens/auth/widgets/custom_text_field.dart';
import 'package:social_app/views/screens/auth/widgets/text_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  void dispose() {
    LoginViewModel().mailLoginController.dispose();
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel =
       LoginViewModel();
    // var authController = Provider.of<AuthController>(context);
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
                padding: EdgeInsets.all(loginViewModel.widthScreen_20),
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
                      key: loginViewModel.formKeyLogin,
                      child: Column(
                        children: [
                          CustomTextField(
                            suffixIcon: Icon(LoginViewModel().userOutlineIcon),
                            controller: loginViewModel.mailLoginController,
                            hintText: loginViewModel.emailString,
                            keyboardType: TextInputType.emailAddress,
                            validator: Tvalidator.emailvalidator,
                          ),
                          Consumer<LoginPasswordHide>(
                            builder: (context, model, child) {
                              return CustomTextField(
                                controller:
                                    LoginPasswordHide.passwordLoginController,
                                hintText: loginViewModel.passwordString,
                                obscureText: model.isHidden,
                                suffixIcon: InkWell(
                                  onTap: model.togglePassword,
                                  child: Icon(model.isHidden
                                      ? LoginViewModel()
                                          .passwordCheckOutlineIcon
                                      : LoginViewModel().passwordCheckBoldIcon),
                                ),
                                keyboardType: TextInputType.text,
                                validator: Tvalidator.passwordValidator,
                              );
                            },
                          ),
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
                              loginViewModel.loginButton(context);
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
