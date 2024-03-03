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
  String? avatar =
      "https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg";
  List<MainUser>? friends = [];
  List<MainUser>? requestesfriends = [];
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
      this.requestesfriends,
      this.userUID});
  static MainUser fromjsontoDart(
      Map<String, dynamic>? jsonfile, User? userInfo,String?directUid) {
    return MainUser(
        avatar: jsonfile!['avatar'],
        email: userInfo?.email ?? "user@example.com",
        friends: [],
        requestesfriends: [],
        posts: [],
        userName: jsonfile['username'],
        bio: jsonfile['bio'],
        phone: jsonfile['phone'],
        aboutMe: jsonfile['aboutMe'],
        address: jsonfile['address'],
        userUID:directUid?? userInfo?.uid ?? "hiii");
  }

  void setUserName(String? name) {
    userName = name;
  }

  void setAboutMe(String? about) {
    aboutMe = about;
  }

  void setBio(String? biography) {
    bio = biography;
  }

  void setPhone(String? phoneNumber) {
    phone = phoneNumber;
  }

  void setAddress(String? userAddress) {
    address = userAddress;
  }

  void setUserUID(String? uid) {
    userUID = uid;
  }

  void setEmail(String? userEmail) {
    email = userEmail;
  }

  void setAvatar(String? userAvatar) {
    avatar = userAvatar;
  }

  void setFriends(List<MainUser>? userFriends) {
    friends = userFriends;
  }
  void setFrequestesfriends(List<MainUser>? userFriends) {
    requestesfriends = userFriends;
  }

  void setPosts(List<Post>? userPosts) {
    posts = userPosts;
  }
}
