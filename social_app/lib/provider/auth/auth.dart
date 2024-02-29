// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/user_model.dart';

class AuthController extends ChangeNotifier {
  late User? user;
  MainUser? mainUser;
  var mailSignUpController = TextEditingController();
  var userNameSignUpController = TextEditingController();
  var passwordSignUpController = TextEditingController();
  var confirmPasswordSignUpController = TextEditingController();
  var mailLoginController = TextEditingController();
  var passwordLoginController = TextEditingController();
  // --------------------- Varibles --------------------
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
      } else {
        firebaseAuthErrorTypSignup = "error";
      }
    }
    return null;
  }

//========================================================================================
  void setUser() {
    user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

//========================================================================================
  Future<void> getdata() async {
    var storage = FirebaseFirestore.instance;
    var users = storage.collection('users');
    var currentUser = users.doc("${user?.uid}");
    var dataUser = await currentUser.get();
    print(dataUser.data()?['username']);
    mainUser = MainUser.fromjsontoDart(dataUser.data(), user);
    print("=====================${mainUser?.userUID}");
    notifyListeners();
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

  Future<void> fireStorageAddNewUser() async {
    await FirebaseFirestore.instance.collection("users").add({
      'full_name': 'fullName', // John Doe
      'company': 'company', // Stokes and Sons
      'age': 'age' // 42
    });

    print("aaaaaaaaaaaaaaaadddddddddddddddeeeeeeeeeeeeed");
  }

// =========================================================================
  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
// =========================================================================