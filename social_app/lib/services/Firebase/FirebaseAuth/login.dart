import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServisesLogin {
  LoginError? _loginErrorType;
  Future<UserCredential?> loginWithEmailAndPassword(
      String mail, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        _loginErrorType = LoginError.networkRequestFailed;
      } else if (e.code == 'invalid-credential') {
        _loginErrorType = LoginError.invalidCredential;
      } else {
        _loginErrorType = LoginError.error;
      }
      return null;
    }
  }
  LoginError get loginErrorType => _loginErrorType!;

  void setloginErrorTypeToNull() {
    _loginErrorType = null;
  }


}

enum LoginError { networkRequestFailed, invalidCredential, error }
