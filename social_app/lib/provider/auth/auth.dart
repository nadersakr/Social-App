// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/model/user_model.dart';

class AuthController extends ChangeNotifier {
  // --------------------- Variables ---------------------
  late User? user;
  MainUser mainUser = MainUser();
  List<MainUser> users = [];
  Map<String, MainUser> usersMap = {};
  List<MainUser> requestesfriendsMainUser = [];
  List<dynamic> pendingfriendsController = [];
  List<dynamic> requestesfriendsController = [];
  List<MainUser> myFriends = [];
  bool isobscureText = true;
  bool isDataLoaded = false;
  bool isFirstTimeGetFriends = true;
  bool isobscureSignpass = true;
  bool isobscureConfirmSignpass = true;
  File? imageFile;
  String? firebaseAuthErrorType;
  String? firebaseAuthErrorTypSignup;
  var formKeySignUp = GlobalKey<FormState>();
  var formKeyLogin = GlobalKey<FormState>();
  var formKeyEditProfile = GlobalKey<FormState>();
  var storage = FirebaseFirestore.instance;

  // --------------------- Text Controllers ------------------------------------------------------------
  var mailSignUpController = TextEditingController();
  var userNameSignUpController = TextEditingController();
  var bioProfileController = TextEditingController();
  var aboutMeProfileController = TextEditingController();
  var phoneProfileController = TextEditingController();
  var addressProfileController = TextEditingController();
  var passwordSignUpController = TextEditingController();
  var confirmPasswordSignUpController = TextEditingController();
  var mailLoginController = TextEditingController();
  var passwordLoginController = TextEditingController();

  // --------------------- Firebase Auth Methods --------------------------------------------------------
  
  // Method to sign up a user with email and password
  Future<UserCredential?> signUp({
    required String mail,
    required String password,
  }) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        firebaseAuthErrorTypSignup = "email-already-in-use";
      } else {
        firebaseAuthErrorTypSignup = "error";
      }
    }
    return null;
  }

  // Method to log in a user with email and password
  Future<UserCredential?> login({
    required String mail,
    required String password,
  }) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'network-request-failed') {
        firebaseAuthErrorType = 'network-request-failed';
      } else if (e.code == 'invalid-credential') {
        firebaseAuthErrorType = "invalid-credential";
      } else {
        firebaseAuthErrorType = "error";
      }
      return null;
    }
  }

  // Method to sign out the current user
Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    isFirstTimeGetFriends = true;
    isDataLoaded = false;
    mainUser = MainUser();
  }

  // --------------------- Firestore Data Methods ----------------------------------------------------------
  
  // Method to get app data
  Future<void> getAppData() async {
    if (!isDataLoaded) {
      user = FirebaseAuth.instance.currentUser;
      await getdata();
      await getFriends();
      setTextControler();
      print("00000000000000000000000000");
      print(mainUser.friends);
      print("00000000000000000000000000");
      // print(mainUser.friends);
      isDataLoaded = true;
    }
  }

  // Method to get user data
  Future<void> getdata() async {
    var storage = FirebaseFirestore.instance;
    var users = storage.collection('users');
    var currentUser = users.doc("${user?.uid}");
    var dataUser = await currentUser.get();
    print(dataUser.data()?['username']);
    mainUser = MainUser.fromjsontoDart(dataUser.data(), user, user?.uid);
    pendingfriendsController = mainUser.pendingfriends!;
    requestesfriendsController = mainUser.requestesfriends ?? [];
    myFriends = await fromUIDListToMainUsers(mainUser.friends ?? []);
    print("=====================${mainUser.userUID}");
    print("=====================${mainUser.requestesfriends}");
    print("=====================${mainUser.pendingfriends}");
    print("=====================${mainUser.friends}");
 
  }

  // Method to add a new user to Firestore
  Future<void> fireStorageAddNewUser() async {
    await FirebaseFirestore.instance.collection("users").add({
      'full_name': 'fullName', // John Doe
      'company': 'company', // Stokes and Sons
      'age': 'age' // 42
    });

    print("aaaaaaaaaaaaaaaadddddddddddddddeeeeeeeeeeeeed");
  }

  // Method to update profile data in Firestore
  upldateProfileData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(mainUser.userUID)
        .update({
      'username': userNameSignUpController.text,
      'bio': bioProfileController.text,
      'aboutMe': aboutMeProfileController.text,
      'phone': phoneProfileController.text,
      'address': addressProfileController.text,
    });
  }

  // Method to update avatar profile data in Firestore
  upldateAvatarProfileData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(mainUser.userUID)
        .update({'avatar': mainUser.avatar});
  }

  // --------------------- Friends Management Methods ---------------------
  
  // Method to get friends of the current user
  Future<void> getFriends() async {
    if (isFirstTimeGetFriends) {
      var snapshot = await storage.collection('users').get();
      users = snapshot.docs.map((doc) {
        MainUser userMain = MainUser.fromjsontoDart(doc.data(), null, doc.id);
        usersMap[doc.id] = userMain;
        return userMain;
      }).toList();

      for (var i = 0; i < requestesfriendsController.length; i++) {
        if (requestesfriendsMainUser
            .where(
                (element) => element.userUID == requestesfriendsController[i])
            .isEmpty) {
          var userFriend = await storage
              .collection('users')
              .doc(requestesfriendsController[i])
              .get();
          MainUser userFriendMain = MainUser.fromjsontoDart(
              userFriend.data(), null, requestesfriendsController[i]);

          requestesfriendsMainUser.add(userFriendMain);
        }
        users.removeWhere(
            (element) => element.userUID == requestesfriendsController[i]);
      }
      mainUser.friends?.forEach((element) {
        users.removeWhere((e) => e.userUID == element);
      });
      users.removeWhere((element) => element.userUID == mainUser.userUID);
      isFirstTimeGetFriends = false;
    }

  }

  // Method to add a user to the requested friends list
Future<void> addMainUserToRequestedFriends(String friendUID) async {
    var currentUserUID = FirebaseAuth.instance.currentUser?.uid;
    var usersCollection = FirebaseFirestore.instance.collection('users');
    pendingfriendsController.add(friendUID);
    if (currentUserUID != null) {
      await usersCollection.doc(friendUID).update({
        'requestesfriends': FieldValue.arrayUnion([currentUserUID])
      });
      await usersCollection.doc(currentUserUID).update({
        'pendingfriends': FieldValue.arrayUnion([friendUID])
      });
    }
    notifyListeners();
  }

  // Method to delete a friend from the friends list
  Future<void> deleteFriendFromLists(String friendUID) async {
    var currentUserUID = user?.uid;
    var usersCollection = FirebaseFirestore.instance.collection('users');
    if (currentUserUID != null) {
      await usersCollection.doc(currentUserUID).update({
        'pendingfriends': FieldValue.arrayRemove([friendUID])
      });
      await usersCollection.doc(friendUID).update({
        'requestesfriends': FieldValue.arrayRemove([currentUserUID])
      });
      pendingfriendsController.remove(friendUID);
    }
    print("==================================================");
    notifyListeners();
  }

  // Method to reject a friend request
  Future<void> rejectRequest(String friendUID) async {
    var currentUserUID = mainUser.userUID;
    var usersCollection = FirebaseFirestore.instance.collection('users');
    if (currentUserUID != null) {
      await usersCollection.doc(currentUserUID).update({
        'requestesfriends': FieldValue.arrayRemove([friendUID])
      });
      var friendMain = usersCollection.doc(friendUID);
      friendMain.update({
        'pendingfriends': FieldValue.arrayRemove([currentUserUID])
      });
      DocumentSnapshot<Map<String, dynamic>> friend = await friendMain.get();
      users.add(MainUser.fromjsontoDart(friend.data(), null, friendUID));
      requestesfriendsController.remove(friendUID);
      pendingfriendsController.remove(friendUID);
      requestesfriendsMainUser
          .removeWhere((element) => element.userUID == friendUID);
      mainUser.requestesfriends = requestesfriendsController;
      mainUser.pendingfriends = pendingfriendsController;
    }
    notifyListeners();
  }

  // Method to accept a friend request
  Future<void> acceptedFriend(String friendUID) async {
    var currentUserUID = mainUser.userUID;
    var usersCollection = FirebaseFirestore.instance.collection('users');
    if (currentUserUID != null) {
      await usersCollection.doc(currentUserUID).update({
        'friends': FieldValue.arrayUnion([friendUID]),
        'requestesfriends': FieldValue.arrayRemove([friendUID])
      });
      await usersCollection.doc(friendUID).update({
        'friends': FieldValue.arrayUnion([currentUserUID]),
        'pendingfriends': FieldValue.arrayRemove([currentUserUID])
      });
      // ----------
      DocumentSnapshot<Map<String, dynamic>> friend =
          await usersCollection.doc(friendUID).get();
      MainUser friendUser =
          MainUser.fromjsontoDart(friend.data(), null, friendUID);

      myFriends.add(friendUser);
      requestesfriendsController.remove(friendUID);
      pendingfriendsController.remove(friendUID);
      requestesfriendsMainUser
          .removeWhere((element) => element.userUID == friendUID);
      mainUser.friends?.add(friendUID);
      mainUser.requestesfriends = requestesfriendsController;
      mainUser.pendingfriends = pendingfriendsController;
    }
    notifyListeners();
  }

  // Method to unfriend a user
  Future<void> unFriend(String friendUID) async {
    var currentUserUID = mainUser.userUID;
    var usersCollection = FirebaseFirestore.instance.collection('users');
    if (currentUserUID != null) {
      await usersCollection.doc(currentUserUID).update({
        'friends': FieldValue.arrayRemove([friendUID]),
      });
      await usersCollection.doc(friendUID).update({
        'friends': FieldValue.arrayRemove([currentUserUID]),
      });
      // ----------
      myFriends.removeWhere((element) => element.userUID == friendUID);
      mainUser.friends?.remove(friendUID);
      MainUser newUser = await fromUIDToMainUser(friendUID);
      users.add(newUser);
    }
    notifyListeners();
  }

  // --------------------- User Profile Methods ---------------------
  
  // Method to add an image file
  void addFileImage(XFile image) {
    imageFile = File(image.path);
    notifyListeners();
  }

  // Method to set the image file to null
  void setImageFileNull() {
    imageFile = null;
  }

  // Method to set the text controller
  void setTextControler() {
    addressProfileController.text = mainUser.address!;
    userNameSignUpController.text = mainUser.userName!;
    bioProfileController.text = mainUser.bio!;
    aboutMeProfileController.text = mainUser.aboutMe!;
    phoneProfileController.text = mainUser.phone!;
  }

  // Method to update the main user from the fields
  void fromFieldsToMainUser() {
    mainUser.userName = userNameSignUpController.text;
    mainUser.bio = bioProfileController.text;
    mainUser.aboutMe = aboutMeProfileController.text;
    mainUser.phone = phoneProfileController.text;
    mainUser.address = addressProfileController.text;
  }

  // Method to convert a list of UIDs to main users
  Future<List<MainUser>> fromUIDListToMainUsers(List<dynamic> myList) async {
    List<MainUser> listOfMainUser = [];
    for (var i = 0; i < myList.length; i++) {
      MainUser userFriendMain = await fromUIDToMainUser(myList[i]);
      listOfMainUser.add(userFriendMain);
    }
    return listOfMainUser;
  }

  // Method to convert a UID to a main user
Future<MainUser> fromUIDToMainUser(String uid) async {
    var storage = FirebaseFirestore.instance;
    var userFriend = await storage.collection('users').doc(uid).get();
    MainUser userFriendMain =
        MainUser.fromjsontoDart(userFriend.data(), null, uid);
    return userFriendMain;
  }

  // --------------------- Visibility Methods ---------------------
  
  // Method to toggle the visibility of the password
  void visibility() {
    isobscureText = !isobscureText;
    print(isobscureText);
    notifyListeners();
  }

  // Method to toggle the visibility of the sign in password
  void visibilitySingPass() {
    isobscureSignpass = !isobscureSignpass;
    print(isobscureSignpass);
    notifyListeners();
  }

  // Method to toggle the visibility of the sign in confirm password
  void visibilitySingConfirmPass() {
    isobscureConfirmSignpass = !isobscureConfirmSignpass;
    print(isobscureConfirmSignpass);
    notifyListeners();
  }
}