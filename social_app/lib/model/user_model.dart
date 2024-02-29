import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/model/post_model.dart';

class MainUser {
  String? userName = "username";
  String? aboutMe = "";
  String? bio = "";
  String? phone = "";
  String? address = "";
  String? userUID = "nnnnnnn";
  String? email = "user@example.com";
  String? avatar = "https://via.placeholder.com/300";
  List<MainUser>? friends = [];
  List<Post>? posts = [];

  MainUser(
      {this.userName,
      this.avatar,
      this.email,
      this.friends,
      this.aboutMe,
      this.phone,
      this.bio,
      this.address,
      this.posts,
      this.userUID});
  static MainUser fromjsontoDart(
      Map<String, dynamic>? jsonfile, User? userInfo) {
    return MainUser(
        avatar: jsonfile!['avatar'],
        email: userInfo?.email ?? "user@example.com",
        friends: [],
        posts: [],
        userName: jsonfile['username'],
        bio: jsonfile['bio'],
        phone: jsonfile['phone'],
        aboutMe: jsonfile['aboutme'],
        address: jsonfile['address'],
        userUID: userInfo?.uid ?? "hiii");
  }
}
