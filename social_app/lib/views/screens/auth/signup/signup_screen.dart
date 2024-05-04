import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/utils/widgets/custom_button.dart';
import 'package:social_app/view_model/sign_up_viewmodel.dart';
import 'package:social_app/views/reusable_components_widgets/validators.dart';
import 'package:social_app/views/screens/auth/login/login_screen.dart';
import 'package:social_app/views/screens/auth/widgets/auth_image_and_text_signup.dart';
import 'package:social_app/views/screens/auth/widgets/custom_text_field.dart';
import 'package:social_app/views/screens/auth/widgets/text_row.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  void dispose() {
    SignUpViewModel.firstNameSignUpController.dispose();
    SignUpViewModel.secondNameSignUpController.dispose();
    SignUpViewModel.mailSignUpController.dispose();
    SignUpViewModel.userNameSignUpController.dispose();
    PasswordHideShow.passwordSignUpController.dispose();
    PasswordHideShow.confirmPasswordSignUpController.dispose();
   
  }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    SignUpViewModel signUpViewModel = SignUpViewModel();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const AuthImageAndTextSignUp(),
              Padding(
                  padding: EdgeInsets.all(signUpViewModel.widthScreen_20),
                  child: Form(
                    key: SignUpViewModel.formKeySignUp,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextField(
                                width: signUpViewModel.widthSpace_150,
                                suffixIcon:
                                    Icon(signUpViewModel.userOutlineIcon),
                                controller:
                                    SignUpViewModel.firstNameSignUpController,
                                hintText: signUpViewModel.firstNameString,
                                maxlenght: 9,
                                keyboardType: TextInputType.text,
                                validator: Tvalidator.firstNameValidator),
                            CustomTextField(
                                maxlenght: 9,
                                width: signUpViewModel.widthSpace_150,
                                suffixIcon:
                                    Icon(signUpViewModel.userOutlineIcon),
                                controller:
                                    SignUpViewModel.secondNameSignUpController,
                                hintText: signUpViewModel.lastNameString,
                                keyboardType: TextInputType.text,
                                validator: Tvalidator.lastNameValidator)
                          ],
                        ),
                        CustomTextField(
                            suffixIcon: Icon(signUpViewModel.smsIcon),
                            controller: SignUpViewModel.mailSignUpController,
                            hintText: signUpViewModel.emailString,
                            keyboardType: TextInputType.emailAddress,
                            validator: Tvalidator.emailvalidator),
                        CustomTextField(
                          suffixIcon:
                              Icon(signUpViewModel.userSearchOutlineIcon),
                          controller: SignUpViewModel.userNameSignUpController,
                          hintText: signUpViewModel.userNameString,
                          keyboardType: TextInputType.text,
                          validator: Tvalidator.usernameValidator,
                        ),
                        Consumer<PasswordHideShow>(
                          builder: (BuildContext context,
                              PasswordHideShow value, Widget? child) {
                            return CustomTextField(
                              controller:
                                  PasswordHideShow.passwordSignUpController,
                              hintText: signUpViewModel.passwordString,
                              suffixIcon: InkWell(
                                  onTap: value.toggleConfirmPassword,
                                  child: Icon(value.isConfirmHidden
                                      ? signUpViewModel.lockedBoldIcon
                                      : signUpViewModel.lockedOutlineIcon)),
                              keyboardType: TextInputType.text,
                              obscureText: value.isConfirmHidden,
                              validator: Tvalidator.passwordValidator,
                            );
                          },
                        ),
                        Consumer<PasswordHideShow>(
                          builder: (BuildContext context,
                              PasswordHideShow value, Widget? child) {
                            return CustomTextField(
                              controller: PasswordHideShow
                                  .confirmPasswordSignUpController,
                              hintText: signUpViewModel.confirmPasswordString,
                              suffixIcon: GestureDetector(
                                  onTap: value.togglePassword,
                                  child: Icon(value.isHidden
                                      ? signUpViewModel.lockedBoldIcon
                                      : signUpViewModel.lockedOutlineIcon)),
                              keyboardType: TextInputType.text,
                              obscureText: value.isHidden,
                              validator: Tvalidator.confirmPasswordValidator,
                            );
                          },
                        ),
                        SizedBox(
                          height: signUpViewModel.heightSpace_30,
                        ),
                        CustomButton(
                          buttonText: signUpViewModel.signUpString,
                          onPressed: () {
                            signUpViewModel.signUp(context);
                          },
                        ),
                        SizedBox(
                          height: signUpViewModel.heightSpace_30,
                        ),
                        TextRow(
                          text: signUpViewModel.alreadyHaveAccount,
                          textButton: signUpViewModel.loginString,
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const LoginScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(0.0, -1.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ));
                          },
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
