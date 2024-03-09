import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/user_model.dart';

class PostController extends ChangeNotifier {
  bool isPostsLoaded = false;
  List<dynamic> posts = [];
  int pointer = 7;
  Future<void> getPosts(MainUser mainUser) async {
    if (!isPostsLoaded) {
    var stroge = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> postsGet =
        await stroge.collection('posts').where('owner',whereIn:[...?mainUser.friends,mainUser.userUID ]).get();
    var postData = postsGet.docs;

    for (var doc in postData) {
      posts.add(doc.data());
      // This prints the document's data as a Map<String, dynamic>
      
    }
    // print('-------  posts  -------');
    // print('posts: $posts');
    // print('-------  posts  -------');
    isPostsLoaded = true;
  }

  //i need to detecte if user liked the post before or not then unlike when tap else like it
  Future<void> likePost({required String liker, required dynamic post}) async {
    if (post['likers'] == null) {
      post['likers'] = [liker];
    } else if (post['likers'].contains(liker)) {
      post['likers'].remove(liker);
    } else {
      post['likers'].add(liker);
    }
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(post['id'])
        .update({'likers': post['likers']});
    notifyListeners();
  }
}
