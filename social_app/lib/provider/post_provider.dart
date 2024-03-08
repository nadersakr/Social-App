import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostController extends ChangeNotifier {
  bool isPostsLoaded = false;
  List<dynamic> posts = [];
  int pointer = 7;
  Future<void> getPosts() async {
    if (!isPostsLoaded) {
    var stroge = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> postsGet =
        await stroge.collection('posts').get();
    var postData = postsGet.docs;

    for (var doc in postData) {
      posts.add(doc.data());
      // This prints the document's data as a Map<String, dynamic>
    }

  }
      isPostsLoaded = true;
    }
}
