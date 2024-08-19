import 'package:social_app/provider/auth/auth.dart';

class Post {
  int postId;
  String owner;
  String time;
  List<String> likes = [];
  Map<String, String> comments = {};
  String? ContentImageurl;
  List<String> shares = [];
  Post(
      {required this.time,
      required this.postId,
      required this.ContentImageurl,
      required this.owner});

 factory Post.OwnPost(String postTime,int postId,String imageUrl) => Post(
      time: postTime,
      postId: postId,
      ContentImageurl: imageUrl,
      owner: AuthController.mainUser.userUID??"");
}
