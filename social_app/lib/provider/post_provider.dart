import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/user_model.dart';

class PostController extends ChangeNotifier {
  bool isPostsLoaded = false;
  bool isLiked = false;
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
      post['isLiked'] = post['likers']?.contains(mainUser.userUID) ?? false;
      posts.add(post);
    }
  }

  Future<void> likePost({required String liker, required dynamic post}) async {
    if (post['likers'] == null) {
      post['likers'] = [liker];
      post['isLiked'] = true;
    } else if (post['likers'].contains(liker)) {
      post['isLiked'] = false;
      post['likers'].remove(liker);

      print("liked removed");
    } else {
      post['likers'].add(liker);
      post['isLiked'] = true;
      isLiked = true;
      print("liked post");
    }
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(post['id'])
        .update({
      'likers': post['likers'],
    });
    notifyListeners();
  }
  //i need to detecte if user liked the post before or not then unlike when tap else like it

  Future<void> addComment(
      {required String comment,
      required String commenter,
      required Map<String, dynamic> post}) async {
    if (post['comments'] == null) {
      post['comments'] = [
        {
          'comment': comment,
          'commenter': commenter,
        }
      ];
    } else {
      post['comments'].add({
        'comment': comment,
        'commenter': commenter,
      });
    }
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(post['id'])
        .update({
      'comments': post['comments'],
    });
    notifyListeners();
  }
}
