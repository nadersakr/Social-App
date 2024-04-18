import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/widgets/custom_button.dart';
import 'package:social_app/views/screens/auth/login/login_screen.dart';
import 'package:social_app/views/screens/auth/widgets/custom_text_field.dart';
import 'package:social_app/views/screens/auth/widgets/text_row.dart';

class AuthFooterSignup extends StatelessWidget {
  const AuthFooterSignup({
    super.key,
  });

  String? validatorPassword(value) {
    if (value!.isEmpty) {
      return 'Fill Password';
    } else if (value.length < 8) {
      return 'Password must be more than 7 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context);

    return Form(
      key: authController.formKeySignUp,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextField(
                  width: 0.45.sw,
                  suffixIcon: const Icon(EneftyIcons.user_outline),
                  controller: authController.firstNameSignUpController,
                  hintText: 'First Name',
                  maxlenght: 9,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name Required';
                    } else if (value.length > 9) {
                      return 'must be less than 10 characters';
                    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  }),
              CustomTextField(
                  maxlenght: 9,
                  width: 0.45.sw,
                  suffixIcon: const Icon(EneftyIcons.user_outline),
                  controller: authController.secondNameSignUpController,
                  hintText: 'Second Name',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Second name Required';
                    } else if (value.length > 9) {
                      return 'must be less than 10 characters';
                    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  })
            ],
          ),
          CustomTextField(
              suffixIcon: const Icon(EneftyIcons.sms_outline),
              controller: authController.mailSignUpController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email address is Required';
                } else if (!RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                    .hasMatch(value)) {
                  return 'pleas enter correct email';
                }
                return null;
              }),
          CustomTextField(
            suffixIcon: const Icon(EneftyIcons.user_search_outline),
            controller: authController.userNameSignUpController,
            hintText: 'username',
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return "username is required";
              } else if (value.length <= 4) {
                return "username must be more than 4 characters";
              }
              return null;
            },
          ),
          CustomTextField(
            controller: authController.passwordSignUpController,
            hintText: 'Password',
            suffixIcon: InkWell(
                onTap: authController.visibilitySingPass,
                child: Icon(authController.isobscureSignpass
                    ? EneftyIcons.lock_2_bold
                    : EneftyIcons.lock_2_outline)),
            keyboardType: TextInputType.text,
            obscureText: authController.isobscureSignpass,
            validator: validatorPassword,
          ),
          CustomTextField(
            controller: authController.confirmPasswordSignUpController,
            hintText: 'Confirm Password',
            suffixIcon: GestureDetector(
                onTap: authController.visibilitySingConfirmPass,
                child: Icon(authController.isobscureConfirmSignpass
                    ? EneftyIcons.lock_2_bold
                    : EneftyIcons.lock_2_outline)),
            keyboardType: TextInputType.text,
            obscureText: authController.isobscureConfirmSignpass,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Fill Password';
              } else if (value.length < 8) {
                return 'Password must be more than 7 characters';
              } else if (value !=
                  authController.passwordSignUpController.text) {
                return 'Confirm Password must match Password';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(
            buttonText: "Sign Up",
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isEqualTo: authController.userNameSignUpController.text)
                  .get()
                  .then((value) {
                if (value.docs.isNotEmpty) {
                  authController.isUserNameExists = true;
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("username already in use")));
                } else {
                  authController.isUserNameExists = false;
                }
              });
              if (authController.formKeySignUp.currentState!.validate() &&
                  !authController.isUserNameExists) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                // Call signUp function
                var usercridatinal = await authController.signUp(
                  mail: authController.mailSignUpController.text,
                  password: authController.passwordSignUpController.text,
                );
                if (usercridatinal != null) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(usercridatinal.user?.uid)
                      .set({
                    'username': authController.userNameSignUpController.text,
                    'friends': [],
                    'requestesfriends': [],
                    'email': authController.mailSignUpController.text,
                  });
                  await FirebaseFirestore.instance
                      .collection('posts')
                      .doc(usercridatinal.user?.uid)
                      .set({
                    'posts': [],
                  });
                }

                if (authController.firebaseAuthErrorTypSignup ==
                    'email-already-in-use') {
                  Navigator.of(context).pop();
                  FocusManager.instance.primaryFocus?.unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("email already in use")));
                } else if (authController.firebaseAuthErrorTypSignup ==
                    "error") {
                  Navigator.of(context).pop();
                  FocusManager.instance.primaryFocus?.unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Error please try again later")));
                } else {
                  Navigator.of(context).pop();
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                }
                authController.firebaseAuthErrorTypSignup = null;
              }
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          TextRow(
            text: 'Already have account?',
            textButton: "Login",
            onPressed: () {
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const LoginScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
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
                transitionDuration: const Duration(milliseconds: 500),
              ));
            },
          )
        ],
      ),
    );
  }
}
