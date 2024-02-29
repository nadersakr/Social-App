import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/utils/widgets/custom_snack_bar.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/utils/shared-preferences/shared_preferences.dart';
import 'package:social_app/utils/widgets/animation_navigat_screen.dart';
import 'package:social_app/utils/widgets/custom_button.dart';
import 'package:social_app/views/screens/Home/home.dart';
import 'package:social_app/views/screens/auth/signup/signup_screen.dart';
import 'package:social_app/views/screens/auth/widgets/custom_text_field.dart';
import 'package:social_app/views/screens/auth/widgets/text_row.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
  });
  String? passwordValidator(value) {
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
    var authControoler = Provider.of<AuthController>(context);
    return Form(
      key: authControoler.formKeyLogin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
              controller: authControoler.mailLoginController,
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
              controller: authControoler.passwordLoginController,
              hintText: 'Password',
              obscureText: authControoler.isobscureText,
              suffixIcon: InkWell(
                  onTap: authControoler.visibility,
                  child: Icon(authControoler.isobscureText
                      ? Icons.visibility
                      : Icons.visibility_off)),
              keyboardType: TextInputType.text,
              validator: passwordValidator),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () async {
              // await FirebaseAuth.instance.sendPasswordResetEmail(
              //     email: authControoler.mailLoginController.text);
              CustomSnackBar.showSuccessSnackBar(context,
                  message: 'Check Your Email',
                  snackBarType: SnackBarType.success);
            },
            child: const Text(
              'FORGOT PASSWORD',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.blue,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            buttontext: "LogIN",
            onPressed: () async {
              if (authControoler.formKeyLogin.currentState!.validate()) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                var usercridatinal = await authControoler.login(
                    mail: authControoler.mailLoginController.text,
                    password: authControoler.passwordLoginController.text);
                authControoler.user = usercridatinal?.user;
                
                if (authControoler.user != null) {
                  authControoler.fireStorageAddNewUser;
                  AppSharedPreferences.setbool(key: 'islogin', value: true);
                  FocusManager.instance.primaryFocus?.unfocus();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false);
                  
                } else {
                  Navigator.of(context).pop();
                  switch (authControoler.firebaseAuthErrorType) {
                    case "invalid-credential":
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("invalid-credential")));
                      break;
                    case "network-request-failed":
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Lost Conntection, please try again later.")));
                      break;
                    default:
                      FocusManager.instance.primaryFocus?.unfocus();
                 
                  }
                }
              }
              authControoler.firebaseAuthErrorType = null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextRow(
            text: 'Don\'t have account?,',
            textButton: "SignUp",
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  AnimationNavigatScreen(const SignupScreen()));
            },
          )
        ],
      ),
    );
  }
}
