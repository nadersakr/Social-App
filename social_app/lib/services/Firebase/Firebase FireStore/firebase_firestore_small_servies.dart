import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/services/Firebase/Firebase%20Storage/upload_image.dart';
import 'package:social_app/view_model/user_viewmodel.dart';

class FireFirestoreSmallServices {
  // upload avatar image

  Future<String?> uploadImage(File imageFile) async {
    String? imageUrl = await FirebaseStorageService().uploadImage(imageFile);
    if (imageUrl != null) {
      return imageUrl;
    }

    return null;
  }

  Future<bool> uploadAndsaveImageUrlTOUserData(File imageFile) async {
    String? imageUrl = await uploadImage(imageFile);
    if (imageUrl != null) {
      return await saveImageUrlIntoUserData(imageUrl);
    }
    return false;
  }

  Future<bool> saveImageUrlIntoUserData(String? imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserViewModel.userModel!.uid)
          .set({
        'avatar': imageUrl,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
