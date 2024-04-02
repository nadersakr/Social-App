import 'package:firebase_auth/firebase_auth.dart';

class MainUser {
  String? userName = "username";
  String? aboutMe = "";
  String? bio = "";
  String? phone = "";
  String? address = "";
  String? userUID = "nnnnnnn";
  String? email = "user@example.com";
  String avatar;
  List<dynamic>? friends = [];
  List<dynamic>? posts = [];
  List<dynamic>? pendingfriends = [];
  List<dynamic>? requestesfriends = [];
  // List<Post>? posts = [];

  MainUser(
      {this.userName,
      this.avatar =
          "https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
      this.email,
      this.friends,
      this.aboutMe,
      this.phone,
      this.bio,
      this.address,
      this.pendingfriends,
      this.posts,
      this.requestesfriends,
      this.userUID});
  static MainUser fromjsontoDart(
      Map<String, dynamic>? jsonfile, User? userInfo, String? directUid) {
    return MainUser(
        avatar: jsonfile!['avatar'] ??
            "https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
        email: jsonfile['email'],
        friends: jsonfile['friends'],
        requestesfriends: jsonfile['requestesfriends'],
        pendingfriends: jsonfile['pendingfriends'] ?? [],
        posts: jsonfile['posts'],
        userName: jsonfile['username'],
        bio: jsonfile['bio'],
        phone: jsonfile['phone'],
        aboutMe: jsonfile['aboutMe'],
        address: jsonfile['address'],
        userUID: directUid ?? userInfo?.uid ?? "hiii");
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
    avatar = userAvatar ??
        "https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg";
  }

  void setFriends(List<String>? userFriends) {
    friends = userFriends;
  }

  void setFrequestesfriends(List<String>? userFriends) {
    requestesfriends = userFriends;
  }

  void setPosts(List<dynamic>? userPosts) {
    posts = userPosts;
  }
}
