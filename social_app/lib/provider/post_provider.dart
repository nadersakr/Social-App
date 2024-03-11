import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/user_model.dart';

class PostController extends ChangeNotifier {
  bool isPostsLoaded = false;
  List<dynamic> posts = [];
  int pointer = 7;
  Future<void> getPosts(MainUser mainUser) async {
    posts.clear();
   
      var stroge = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> postsGet = await stroge
          .collection('posts')
          .where('owner',
              whereIn: [...?mainUser.friends, mainUser.userUID]).get();
      var postData = postsGet.docs;

      for (var doc in postData) {
        Map<String, dynamic> post = {...doc.data(), 'id': doc.id};
        posts.add(post);
      }
    
    // print('-------  posts  -------');
    // print('posts: $posts');
    // print('-------  posts  -------');
  
  }

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
  //i need to detecte if user liked the post before or not then unlike when tap else like it
}
