import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      return 'Password must be more than 8 characters';
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
          const SizedBox(
            height: 30,
          ),
          CustomTextField(
              controller: authController.mailSignUpController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'field email address';
                } else if (!RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                    .hasMatch(value)) {
                  return 'pleas enter correct email';
                }
                return null;
              }),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: authController.userNameSignUpController,
            hintText: 'username',
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return "username is required";
              } else if (value.length < 4) {
                return "username must be more than 3 characters";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: authController.passwordSignUpController,
            hintText: 'Password',
            suffixIcon: InkWell(
                onTap: authController.visibilitySingPass,
                child: Icon(authController.isobscureSignpass
                    ? Icons.visibility
                    : Icons.visibility_off)),
            keyboardType: TextInputType.text,
            obscureText: authController.isobscureSignpass,
            validator: validatorPassword,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: authController.confirmPasswordSignUpController,
            hintText: 'Confirm Password',
            suffixIcon: InkWell(
                onTap: authController.visibilitySingConfirmPass,
                child: Icon(authController.isobscureConfirmSignpass
                    ? Icons.visibility
                    : Icons.visibility_off)),
            keyboardType: TextInputType.text,
            obscureText: authController.isobscureConfirmSignpass,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Fill Password';
              } else if (value.length < 8) {
                return 'Password must be more than 8 characters';
              } else if (value !=
                  authController.passwordSignUpController.text) {
                return 'Confirm Password must match Password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            buttontext: "Sign Up",
            onPressed: () async {
              // Show circular progress indicator

              if (authController.formKeySignUp.currentState!.validate()) {
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
                    'email': authController.mailSignUpController.text,
                    'bio': '',
                    'aboutMe': '',
                    'phone': '',
                    'address': '',
                    'avatar':''
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
                // Dismiss circular progress indicator

                // Navigate to LoginScreen
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextRow(
            text: 'Already have account?',
            textButton: "Login",
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          )
        ],
      ),
    );
  }
}
