// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/model/user_model.dart';

class AuthController extends ChangeNotifier {
  late User? user;
  MainUser mainUser=MainUser();
  List<MainUser> friends = [];
  List<MainUser> requestesfriendsMainUser = [];
  List<dynamic> pendingfriendsController = [];
  List<dynamic> requestesfriendsController = [];
  List<MainUser> myFriends = [];
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
  // --------------------- Varibles --------------------
  bool isobscureText = true;
  bool isobscureSignpass = true;
  bool isobscureConfirmSignpass = true;
  File? imageFile;
  String? firebaseAuthErrorType;
  String? firebaseAuthErrorTypSignup;
  var formKeySignUp = GlobalKey<FormState>();
  var formKeyLogin = GlobalKey<FormState>();
  var formKeyEditProfile = GlobalKey<FormState>();
  //! --------------------- Methods ---------------------
  void addFileImage(XFile image) {
    imageFile = File(image.path);
    notifyListeners();
  }

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

  upldateAvatarProfileData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(mainUser.userUID)
        .update({'avatar': mainUser.avatar});
  }

  void setImageFileNull() {
    imageFile = null;
  }

  void visibility() {
    isobscureText = !isobscureText;
    print(isobscureText);
    notifyListeners();
  }

  void visibilitySingPass() {
    isobscureSignpass = !isobscureSignpass;
    print(isobscureSignpass);
    notifyListeners();
  }

  void visibilitySingConfirmPass() {
    isobscureConfirmSignpass = !isobscureConfirmSignpass;
    print(isobscureConfirmSignpass);
    notifyListeners();
  }

  Future<void> getFriends() async {
    var storage = FirebaseFirestore.instance;
    var snapshot = await storage.collection('users').get();
    friends = snapshot.docs
        .map((doc) => MainUser.fromjsontoDart(doc.data(), null, doc.id))
        .toList();

    for (var i = 0; i < requestesfriendsController.length; i++) {
      var userFriend = await storage
          .collection('users')
          .doc(requestesfriendsController[i])
          .get();
      MainUser userFriendMain = MainUser.fromjsontoDart(
          userFriend.data(), null, requestesfriendsController[i]);
      requestesfriendsMainUser.add(userFriendMain);
      friends.removeWhere(
          (element) => element.userUID == requestesfriendsController[i]);
    }

    friends.removeWhere((element) => element.userUID == mainUser.userUID);
    // var userdata = snapshot.docs.where((element) => requestesfriendsController.contains(element.id));
    //  requestesfriendsMainUser =  userdata.map((e) => MainUser.fromjsontoDart(e.data(), null, requestesfriendsController[i])).toList();

    notifyListeners();
  }

  // ================================set  text controller ======================================
  Future<List<MainUser>> fromUIDListToMainUsers(List<dynamic> myList) async {
    List<MainUser> listOfMainUser = [];
    var storage = FirebaseFirestore.instance;
    for (var i = 0; i < myList.length; i++) {
      var userFriend = await storage.collection('users').doc(myList[i]).get();
      MainUser userFriendMain =
          MainUser.fromjsontoDart(userFriend.data(), null, myList[i]);
      listOfMainUser.add(userFriendMain);
    }
    return listOfMainUser;
  }

  // ================================set  text controller ======================================
  void setTextControler() {
    addressProfileController.text = mainUser.address!;
    userNameSignUpController.text = mainUser.userName!;
    bioProfileController.text = mainUser.bio!;
    aboutMeProfileController.text = mainUser.aboutMe!;
    phoneProfileController.text = mainUser.phone!;
  }
  //*====================================================================================

  void fromFieldsToMainUser() {
    mainUser.userName = userNameSignUpController.text;
    mainUser.bio = bioProfileController.text;
    mainUser.aboutMe = aboutMeProfileController.text;
    mainUser.phone = phoneProfileController.text;
    mainUser.address = addressProfileController.text;
  }

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

  // ==========================================================
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
      friends.add(MainUser.fromjsontoDart(friend.data(), null, friendUID));
      requestesfriendsController.remove(friendUID);
      pendingfriendsController.remove(friendUID);
      requestesfriendsMainUser
          .removeWhere((element) => element.userUID == friendUID);
      mainUser.requestesfriends = requestesfriendsController;
      mainUser.pendingfriends = pendingfriendsController;
    }
    notifyListeners();
  }

  //*====================================================================================
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

  //*====================================================================================
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

//========================================================================================
  Future<void> setUser() async {
    user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

//========================================================================================
  Future<void> getdata() async {
    var storage = FirebaseFirestore.instance;
    var users = storage.collection('users');
    var currentUser = users.doc("${user?.uid}");
    var dataUser = await currentUser.get();
    print(dataUser.data()?['username']);
    mainUser = MainUser.fromjsontoDart(dataUser.data(), user, null);
    pendingfriendsController = mainUser.pendingfriends!;
    requestesfriendsController = mainUser.requestesfriends ?? [];
    myFriends = await fromUIDListToMainUsers(mainUser.friends??[]);
    print("=====================${mainUser.userUID}");
    print("=====================${mainUser.requestesfriends}");
    print("=====================${mainUser.pendingfriends}");
    print("=====================${mainUser.friends}");
    print("=====================${mainUser.friends}");

    notifyListeners();
  }

  //*====================================================================================
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

  Future<void> fireStorageAddNewUser() async {
    await FirebaseFirestore.instance.collection("users").add({
      'full_name': 'fullName', // John Doe
      'company': 'company', // Stokes and Sons
      'age': 'age' // 42
    });

    print("aaaaaaaaaaaaaaaadddddddddddddddeeeeeeeeeeeeed");
  }

// =========================================================================
  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
// =========================================================================