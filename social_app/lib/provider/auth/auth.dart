// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/model/user_model.dart';

class AuthController extends ChangeNotifier {
  late User? user;
  MainUser? mainUser;
  var mailSignUpController = TextEditingController();
  var userNameSignUpController = TextEditingController();
  var bioProfileController = TextEditingController();
  var aboutMeProfileController = TextEditingController();
  var phoneProfileController = TextEditingController();
  var addressProfileController = TextEditingController();
  var passwordSignUpController = TextEditingController();
  var confirmPasswordSignUpController = TextEditingController();
  var mailLoginController = TextEditingController();
  var passwordLoginController = TextEditingController();
  // --------------------- Varibles --------------------
  bool isobscureText = true;
  bool isobscureSignpass = true;
  bool isobscureConfirmSignpass = true;
  File? imageFile;
  String? firebaseAuthErrorType;
  String? firebaseAuthErrorTypSignup;
  var formKeySignUp = GlobalKey<FormState>();
  var formKeyLogin = GlobalKey<FormState>();
  var formKeyEditProfile = GlobalKey<FormState>();
  //! --------------------- Methods ---------------------
  void addFileImage(XFile image) {
    imageFile = File(image.path);
    notifyListeners();
  }
  upldateProfileData( ) async {
    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(mainUser?.userUID)
                        .update({
                      'username':
                          userNameSignUpController.text,
                      'bio': bioProfileController.text,
                      'aboutMe': aboutMeProfileController.text,
                      'phone': phoneProfileController.text,
                      'address': addressProfileController.text,
                      'avatar': mainUser?.avatar
                    });
  }
  void setImageFileNull() {
    imageFile = null;
    
  }

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

  // ================================set  text controller ======================================
  void setTextControler() {
    addressProfileController.text = mainUser!.address!;
    userNameSignUpController.text = mainUser!.userName!;
    bioProfileController.text = mainUser!.bio!;
    aboutMeProfileController.text = mainUser!.aboutMe!;
    phoneProfileController.text = mainUser!.phone!;
  }
  //*====================================================================================

  void fromFieldsToMainUser() {
    mainUser?.userName = userNameSignUpController.text;
    mainUser?.bio = bioProfileController.text;
    mainUser?.aboutMe = aboutMeProfileController.text;
    mainUser?.phone = phoneProfileController.text;
    mainUser?.address = addressProfileController.text;
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
  Future<void> setUser() async {
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