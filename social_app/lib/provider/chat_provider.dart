import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/chat_model.dart';
import 'package:social_app/model/message.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/provider/auth/auth.dart';

class ChatServises extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }

  List<Message> messages = [];
  List<Chat> chats = [];
  bool isLoaded = false;
  //how to get chats of current user from realtime database from firebase
  // List<MainUser> chatsMainUser = [];

  Stream getChatsStream(AuthController authController) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authController.mainUser.userUID)
        .collection('chats')
        .snapshots();
  }
  // ==================================================
  // this method is used to get messages from the chat of the current user with the other user
  // Future<void> getMessages(
  //     AuthController authController, MainUser resevier) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(authController.mainUser.userUID)
  //       .collection('chats')
  //       .doc(resevier.userUID)
  //       .collection('messages')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     for (var doc in querySnapshot.docs) {
  //       messages.add(Message.fromJson(doc.data() as Map<String, dynamic>));
  //     }
  //   });
  // }

  //create getMessagesStream
  Stream getMessagesStream(AuthController authController, MainUser resevier) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authController.mainUser.userUID)
        .collection('chats')
        .doc(resevier.userUID)
        .collection('messages')
        .snapshots();
  }
  // ==================================================

  // this method is used to send messages to the chat of the current user with the other user
  Future<void> sendmessage(
      text, AuthController authController, MainUser resevier) async {
    var doc = FirebaseFirestore.instance
        .collection('users')
        .doc(authController.mainUser.userUID)
        .collection('chats')
        .doc(resevier.userUID);
    await doc.set({
      'lastMessage': text,
      'time': DateTime.now().toString(),
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authController.mainUser.userUID)
        .collection('chats')
        .doc(resevier.userUID)
        .collection('messages')
        .doc()
        .set({
      'message': text,
      'time': DateTime.now().toString(),
      'isMe': true,
    });
    var doc2 = FirebaseFirestore.instance
        .collection('users')
        .doc(resevier.userUID)
        .collection('chats')
        .doc(authController.mainUser.userUID);
    await doc2.set({
      'lastMessage': text,
      'time': DateTime.now().toString(),
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(resevier.userUID)
        .collection('chats')
        .doc(authController.mainUser.userUID)
        .collection('messages')
        .doc()
        .set({
      'message': text,
      'time': DateTime.now().toString(),
      'isMe': false,
    });
  }
}
