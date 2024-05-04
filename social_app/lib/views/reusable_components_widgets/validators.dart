import 'package:social_app/view_model/sign_up_viewmodel.dart';

class Tvalidator {
  static String? emailvalidator(value) {
    if (value == null || value.isEmpty) {
      return 'Eamil is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(value) {
    if (value!.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be more than 8 characters';
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(value) {
    if (value!.isEmpty) {
      return 'Confirm Password is required';
    } else if (value != PasswordHideShow.passwordSignUpController.text) {

      return "Confirm Password doesn't match";
    } else {
      return null;
    }
  }

  static String? usernameValidator(value) {
    if (value!.isEmpty) {
      return SignUpViewModel().usernameRequired;
    } else if (value.length < 4) {
      return SignUpViewModel().usernameMoreThan4;
    }
    return null;
  }

  static String? firstNameValidator(value) {
    if (value == null || value.isEmpty) {
      return SignUpViewModel().firstnameRequired;
    } else if (value.length > 9) {
      return SignUpViewModel().nameLessThan10char;
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return SignUpViewModel().enterValidName;
    }
    return null;
  }

  static String? lastNameValidator(value) {
    if (value == null || value.isEmpty) {
      return SignUpViewModel().lastnameRequired;
    } else if (value.length > 9) {
      return SignUpViewModel().nameLessThan10char;
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return SignUpViewModel().enterValidName;
    }
    return null;
  }
}
