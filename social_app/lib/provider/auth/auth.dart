// ignore_for_file: avoid_print


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  late UserCredential? mainUser;
  late User? user;
  var mailSignUpController = TextEditingController();
  var passwordSignUpController = TextEditingController();
  var confirmPasswordSignUpController = TextEditingController();
  var mailLoginController = TextEditingController();
  var passwordLoginController = TextEditingController();
  //! --------------------- Varibles --------------------
  bool isobscureText = true;
  bool isobscureSignpass = true;
  bool isobscureConfirmSignpass = true;
  String? firebaseAuthErrorType;
  String? firebaseAuthErrorTypSignup;
  var formKeySignUp = GlobalKey<FormState>();
  var formKeyLogin = GlobalKey<FormState>();
  //! --------------------- Methods ---------------------
  void visibility() {
    isobscureText = !isobscureText;
    print(isobscureText);
    notifyListeners();
  }

   Future<void> initializeUser() async {
    user = FirebaseAuth.instance.currentUser ;
    notifyListeners(); // Notify listeners after user initialization
  }
  void visibilitySingPass() {
    isobscureSignpass = !isobscureSignpass;
    print(isobscureSignpass);
    notifyListeners();
  }

  void visibilitySingConfirmPass() {
    isobscureConfirmSignpass = !isobscureConfirmSignpass;
    print(isobscureConfirmSignpass);
    notifyListeners();
  }

  //*====================================================================================

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
        firebaseAuthErrorTypSignup = "email-already-in-use";
      }else{
        firebaseAuthErrorTypSignup = "error";

      } 
     
    }
    return null;
  }
 void setUser() {
    user = FirebaseAuth.instance.currentUser;
  }
  Future<void> getdata() async {

    var userreference = FirebaseFirestore.instance
        .collection('users')
        .doc("${user?.uid}");
    var data = await userreference.get();
    print("=====================================${data.data()}");

    // print(data.docs("ELOMMsClYdcTZcLUKrlDeBYsATJ2").data());
  
  }
  //*====================================================================================
  Future<UserCredential?> login({
    required String mail,
    required String password,
  }) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'network-request-failed') {
        firebaseAuthErrorType = 'network-request-failed';
      } else if (e.code == 'invalid-credential') {
        firebaseAuthErrorType = "invalid-credential";
      } else {
        firebaseAuthErrorType = "error";
      }
      return null;
    }
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
