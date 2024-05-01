import 'package:flutter/material.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/shared-preferences/shared_preferences.dart';
import 'package:social_app/views/screens/Home/home.dart';

class LoginFunctions {
  static Future<void> loginFunction(
      AuthController authControoler, BuildContext context) async {
    {
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
                  content: Text("Lost Conntection, please try again later.")));
              break;
            default:
              FocusManager.instance.primaryFocus?.unfocus();
          }
        }
      }
      authControoler.firebaseAuthErrorType = null;
    }
  }
}