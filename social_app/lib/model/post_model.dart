import 'package:social_app/model/user_model.dart';

class Post {
  String? postId = "nnnnnnnnn";
  MainUser? owner;
  List<MainUser> likes = [];
  Map<MainUser, String> comments = {};
  String? imageurl = "https://via.placeholder.com/300";
  List<MainUser> shares = [];
}
