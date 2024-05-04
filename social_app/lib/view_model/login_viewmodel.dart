import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/services/Firebase/FirebaseAuth/login.dart';
import 'package:social_app/utils/dinmentions.dart';
import 'package:social_app/utils/widgets/show_processing_indecator.dart';
import 'package:social_app/views/home_demo.dart';
import '../utils/shared-preferences/shared_preferences.dart';

class LoginViewModel
    with loginStrings, loginAssets, loginDimentions, loginIcons {
  User? _loginUser;
  var mailLoginController = TextEditingController();

  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  Future<UserCredential?> login() async {
    return await FirebaseServisesLogin().loginWithEmailAndPassword(
        mailLoginController.text,
        LoginPasswordHide._passwordLoginController.text);
  }

  void loginButton(BuildContext context) async {
    {
      if (formKeyLogin.currentState!.validate()) {
        // to show the indecator
        ShowIndecator().showCircularProgress(context);
        // login the user
        var usercridatinal = await FirebaseServisesLogin()
            .loginWithEmailAndPassword(mailLoginController.text,
                LoginPasswordHide._passwordLoginController.text);

        _loginUser = usercridatinal?.user;

        if (loginUser != null) {
          // save the user login state
          AppSharedPreferences.setbool(key: 'islogin', value: true);
          FocusManager.instance.primaryFocus?.unfocus();

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeDemo(),
              ),
              (route) => false);
        } else {
          // to stop the indecator
          ShowIndecator().disposeTheShownWidget(context);

          // to show the error in the snackbar
          // if the user enter wrong email or password or lost connection

          switch (FirebaseServisesLogin().loginErrorType) {
            case LoginError.invalidCredential:
              FocusManager.instance.primaryFocus?.unfocus();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invalid Email or Password.")));
              break;
            case LoginError.networkRequestFailed:
              FocusManager.instance.primaryFocus?.unfocus();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Lost Conntection, please try again later.")));
              break;
            default:
              FocusManager.instance.primaryFocus?.unfocus();
          }
        }
      }
      // to return loginErrorType to null after the user close the snackbar
      FirebaseServisesLogin().setloginErrorTypeToNull();
    }
  }

  User? get loginUser => _loginUser;
  set loginUser(User? value) {
    _loginUser = value;
  }
}

// Mixins for Strings, Assets, Dimentions
mixin loginStrings {
// Strings
  String emailString = 'Email';
  String passwordString = 'Password';
  String forgetPasswordString = 'Forgot Password?';
  String loginString = 'Login';
  String loginToYouAccoundString = 'Login to your account';
  String signUpString = 'Sign Up';
  String doYouHaveAccountString = 'Don\'t have an account?';
}
mixin loginAssets {
  String get svg => 'assets/svg/1.svg';
}
mixin loginDimentions {
  double heightScreen_20 = Dimention.heightScreen_20;
  double heightSpace_30 = Dimention.smallHeightSpace_30;
  double heightSpace_150 = Dimention.heightSpace_150;
  double smallFont = Dimention.smallFont;
  double widthScreen_20 = Dimention.widthScreen_20;
}

mixin loginIcons {
  IconData get userOutlineIcon => EneftyIcons.user_outline;
  IconData get passwordCheckOutlineIcon => EneftyIcons.password_check_outline;
  IconData get passwordCheckBoldIcon => EneftyIcons.password_check_bold;
}

class LoginPasswordHide extends ChangeNotifier {
  static final TextEditingController _passwordLoginController =
      TextEditingController();
  static TextEditingController get passwordLoginController =>
      _passwordLoginController;
  bool _isHidden = true;
  bool get isHidden => _isHidden;
  void togglePassword() {
    _isHidden = !_isHidden;
    notifyListeners();
  }
}
