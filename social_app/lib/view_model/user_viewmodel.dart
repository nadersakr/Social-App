import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/user_model_.dart';
import 'package:social_app/services/Firebase/Firebase%20FireStore/load_user_data.dart';
import 'package:social_app/utils/shared-preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  static UserCredential? userCredintial;
  static UserModel? userModel;

  Future<UserModel?> loadingMyUserDataToUserModel() async {
    // if login in the first time
    if (userCredintial != null) {
      try {
        userModel = await FirebasefirestoreLoadUserData()
            .loadAUserData(userCredintial!.user!.uid);
        return userModel;
      } catch (e) {
        return null;
      }
    }
    // if the user open the app without login again
    String? key = AppSharedPreferences.getValueString(value: "uid");
    if (key != null) {
      try {
        userModel = await FirebasefirestoreLoadUserData().loadAUserData(key);
        return userModel;
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
