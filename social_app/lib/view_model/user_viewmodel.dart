import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/user_model_.dart';
import 'package:social_app/services/Firebase/Firebase%20FireStore/load_user_data.dart';

class UserViewModel extends ChangeNotifier {
  static UserCredential? userCredintial;
  UserModel? userModel;
  Future<bool> loadingUser() async {
    if (userCredintial != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loadingMyUserData() async {
    print("*********************************");
    print(userCredintial!.user!.email);
    if (userModel != null) {
      return true;
    }
    try {
      userModel = await FirebasefirestoreLoadUserData()
          .loadAUserData(userCredintial!.user!.uid);
      if (userModel != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
