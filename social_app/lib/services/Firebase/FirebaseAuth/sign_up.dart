import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthSignUp{
  // enum to handle the error that may happen during the sign up process

  static SignUpError? signUpError;

  // Method to sign up a user with email and password
  Future<UserCredential?> signUp({
    required String mail,
    required String password,
  }) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        signUpError = SignUpError.emailAlreadyInUse;
        // firebaseAuthErrorTypSignup = "email-already-in-use";
      } else {
        signUpError = SignUpError.error;
        // firebaseAuthErrorTypSignup = "error";
      }
    }
    return null;
  }
}

// enum to handle the error that may happen during the sign up process
enum SignUpError { emailAlreadyInUse, error }