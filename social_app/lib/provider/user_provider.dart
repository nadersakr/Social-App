import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MainUser extends ChangeNotifier{
  String? userName = "username";
  String? aboutMe = "";
  String? bio = "";
  String? phone = "";
  String? address = "";
  String? userUID = "nnnnnnn";
  String? email = "user@example.com";
  String? avatar =
      "https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg";
  List<dynamic>? friends = [];
  List<dynamic>? pendingfriends = [];
  List<dynamic>? requestesfriends = [];
  // List<Post>? posts = [];

  MainUser(
      {this.userName,
      this.avatar,
      this.email,
      this.friends,
      this.aboutMe,
      this.phone,
      this.bio,
      this.address,
      this.pendingfriends,
      // this.posts,
      this.requestesfriends,
      this.userUID});
  static MainUser fromjsontoDart(
      Map<String, dynamic>? jsonfile, User? userInfo,String?directUid) {
    return MainUser(
        avatar: jsonfile!['avatar'],
        email: jsonfile['email'],
        friends: jsonfile['friends'],
        requestesfriends:jsonfile['requestesfriends'],
        pendingfriends:jsonfile['pendingfriends'],
        // posts: [],
        userName: jsonfile['username'],
        bio: jsonfile['bio'],
        phone: jsonfile['phone'],
        aboutMe: jsonfile['aboutMe'],
        address: jsonfile['address'],
        userUID:directUid?? userInfo?.uid ?? "hiii");
        
  }
Map<String, dynamic> toJson() {
  return {
    'userName': userName,
    'aboutMe': aboutMe,
    'bio': bio,
    'phone': phone,
    'address': address,
    'userUID': userUID,
    'email': email,
    'avatar': avatar,
    // Assuming you will handle the serialization of friends, requestsfriends, and posts separately
  };
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

  void setFriends(List<String>? userFriends) {
    friends = userFriends;
  }
  void setFrequestesfriends(List<String>? userFriends) {
    requestesfriends = userFriends;
  }

  // void setPosts(List<Post>? userPosts) {
  //   posts = userPosts;
  // }
}
