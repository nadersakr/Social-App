import 'package:social_app/model/user_model.dart';

class Post {
  String? postId = "nnnnnnnnn";
  MainUser? owner;
  List<MainUser> likes = [];
  Map<MainUser, String> comments = {};
  String? imageurl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYscfUBUbqwGd_DHVhG-ZjCOD7MUpxp4uhNe7toUg4ug&s";
  List<MainUser> shares = [];
}
