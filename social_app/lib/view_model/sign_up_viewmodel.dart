import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:social_app/services/Firebase/Firebase%20FireStore/sign_up_fireStore.dart';
import 'package:social_app/services/Firebase/FirebaseAuth/Sign_up.dart';
import 'package:social_app/utils/dinmentions.dart';
import 'package:social_app/utils/widgets/show_processing_indecator.dart';
import 'package:social_app/view_model/user_viewmodel.dart';
import 'package:social_app/views/screens/auth/login/login_screen.dart';

class SignUpViewModel with strings, signUpDimentions, icons {
  // Variables
  static final TextEditingController _firstNameSignUpController =
      TextEditingController();
  static final TextEditingController _secondNameSignUpController =
      TextEditingController();
  static final TextEditingController _mailSignUpController =
      TextEditingController();
  static final TextEditingController _userNameSignUpController =
      TextEditingController();
  static final GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
  static TextEditingController get firstNameSignUpController =>
      _firstNameSignUpController;
  static TextEditingController get secondNameSignUpController =>
      _secondNameSignUpController;
  static TextEditingController get mailSignUpController =>
      _mailSignUpController;
  static TextEditingController get userNameSignUpController =>
      _userNameSignUpController;

  static bool? _isUserNameExists;

  // Methods
  Future<void> signUp(BuildContext context) async {
    if (SignUpViewModel.formKeySignUp.currentState!.validate()) {
      try {
        // check if the username is already existed
        _isUserNameExists = await FireStoreService()
            .isUsernameExisted(_userNameSignUpController.text);
        if (_isUserNameExists != null) {
          if (!_isUserNameExists!) {
            /* 
            - show the indecator
            - sign up the user
            - save the user data in the firestore
            - clear the controllers
            - go to the login screen
            - hide the indecator
            - hide the keyboard
                      */
            ShowIndecator().showCircularProgress(context);
            UserViewModel.userCredintial = await FireBaseAuthSignUp().signUp(
              mail: mailSignUpController.text,
              password: PasswordHideShow.passwordSignUpController.text,
            );
            if ( UserViewModel.userCredintial != null) {
              /* 
              1 - save the user data in the firestore
              2 - clear the controllers
              3 - go to the login screen
              */
              // save the user data in the firestore
              FireStoreService().saveUser(
                firstNameSignUpController.text,
                secondNameSignUpController.text,
                mailSignUpController.text,
                userNameSignUpController.text,
                 UserViewModel.userCredintial!.user!.uid,
              );
              // clear the controllers
              clearControllers();
              // go to the login screen
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );

              return;
            } else {
              if (FireBaseAuthSignUp.signUpError ==
                  SignUpError.emailAlreadyInUse) {
                ShowIndecator()
                    .showSnackBar(context, 'Email is already in use');
              } else {
                ShowIndecator().showSnackBar(context, 'Error in connection');
              }
            }
            // to hide the indecator
            ShowIndecator().disposeTheShownWidget(context);
            // to hide the keyboard
            FocusManager.instance.primaryFocus?.unfocus();
          } else {
            // if the username is existed
            ShowIndecator().showSnackBar(context, 'Username is already in use');
            return;
          }
        } else {
          // if error in connection
          ShowIndecator().showSnackBar(context, 'Error is happened');
        }
      } catch (e) {
        ShowIndecator().showSnackBar(context, 'Error is happened');
      }
    }
  }

  void clearControllers() {
    _firstNameSignUpController.clear();
    _secondNameSignUpController.clear();
    _mailSignUpController.clear();
    _userNameSignUpController.clear();
    PasswordHideShow.passwordSignUpController.clear();
    PasswordHideShow.confirmPasswordSignUpController.clear();
  }
}

// mixins
mixin strings {
  String firstNameString = 'First Name';
  String lastNameString = 'Last Name';
  String nameLessThan10char = 'Name must be less than 10 characters';
  String emailString = 'Email';
  String passwordString = 'Password';
  String confirmPasswordString = 'Confirm Password';
  String signUpString = 'Sign Up';
  String userNameString = 'username';
  String alreadyHaveAccount = 'Already have an account?';
  String loginString = 'Login';
  String firstnameRequired = 'Fill First Name';
  String lastnameRequired = 'Fill Last Name';
  String emailRequired = 'Email is required';
  String passwordRequired = 'Password is required';
  String confirmPasswordRequired = 'Confirm Password is required';
  String passwordNotMatch = 'Password not match';
  String emailNotValid = 'Email is not valid';
  String passwordLength = 'Password must be at least 8 characters';
  String usernameRequired = 'Username is required';
  String usernameMoreThan3 = "username must be more than 3 characters";
  String enterValidName = 'Enter a valid name';
}
mixin icons {
  IconData get userOutlineIcon => EneftyIcons.user_outline;
  IconData get smsIcon => EneftyIcons.sms_outline;
  IconData get userSearchOutlineIcon => EneftyIcons.user_search_outline;
  IconData get lockedBoldIcon => EneftyIcons.lock_2_bold;
  IconData get lockedOutlineIcon => EneftyIcons.lock_2_outline;
}
mixin signUpDimentions {
  double heightScreen_20 = Dimention.heightScreen_20;
  double heightSpace_30 = Dimention.smallHeightSpace_30;
  double heightSpace_150 = Dimention.heightSpace_150;
  double widthScreen_20 = Dimention.widthScreen_20;
  double widthSpace_30 = Dimention.smallWidthSpace_30;
  double widthSpace_150 = Dimention.widthSpace_150;

  double smallFont = Dimention.smallFont;
}

class PasswordHideShow extends ChangeNotifier {
  static final TextEditingController _passwordSignUpController =
      TextEditingController();
  static final TextEditingController _confirmPasswordSignUpController =
      TextEditingController();

  static TextEditingController get passwordSignUpController =>
      _passwordSignUpController;
  static TextEditingController get confirmPasswordSignUpController =>
      _confirmPasswordSignUpController;
  bool _isHidden = true;
  bool _isConfirmHidden = true;
  bool get isHidden => _isHidden;
  bool get isConfirmHidden => _isConfirmHidden;
  void togglePassword() {
    _isHidden = !_isHidden;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    _isConfirmHidden = !_isConfirmHidden;
    notifyListeners();
  }
}
