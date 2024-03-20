class Tvalidator {
  static String? emailvalidator(value) {
    if (value == null || value.isEmpty) {
      return 'field email address';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'pleas enter correct email';
    }
    return null;
  }

  static String? passwordValidator(value) {
    if (value!.isEmpty) {
      return 'Fill Password';
    } else if (value.length < 8) {
      return 'Password must be more than 8 characters';
    } else {
      return null;
    }
  }
}
