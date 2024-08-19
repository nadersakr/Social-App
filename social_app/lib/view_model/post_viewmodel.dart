import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:social_app/provider/auth/auth.dart';

class PostViewmodel {
  Future<void> addPost(
      File? image,
      BuildContext context,
      AuthController authController,
      int hour,
      DateTime now,
      String amPm) async {
    if (image != null) {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      var storage = FirebaseFirestore.instance;
      var user =
          storage.collection("users").doc(AuthController.mainUser.userUID);
      var posts =
          storage.collection("posts").doc(AuthController.mainUser.userUID);

      // Upload image to Firebase Storage
      String? imageUrl;

      try {
        // Create a reference to the file location in Firebase Storage
        Reference ref = FirebaseStorage.instance.ref().child(
              'posts/${path.basename(image.path)}',
            );

        // Upload the file to Firebase Storage
        await ref.putFile(image);

        // Get the download URL
        imageUrl = await ref.getDownloadURL();
      } catch (e) {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.of(context).pop();
        SnackBar snackBar = const SnackBar(
          content: Text('Failed to upload image'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      Map<String, String> post = {
        'time':
            '${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $amPm, ${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString().padLeft(2, '0')}',
        'imageUrl': imageUrl ??
            "https://firebasestorage.googleapis.com/v0/b/social-app-89a41.appspot.com/o/path%2Fto%2Fstorage%2F1000003515.jpg?alt=media&token=829cf6ad-5c7c-4dc1-84a7-6cdbd18e4c80", // Add the image URL to the document
      };
      print(AuthController.mainUser.userUID);
      print("-=========================================");
      print(AuthController.mainUser.userUID);
      // Add the post document with the image URL
      await user.set({
        'posts': FieldValue.arrayUnion([post]),
      });
      await posts.set({
        'posts': FieldValue.arrayUnion([post])
      });
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.of(context).pop();
    }
  }
}
