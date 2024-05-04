import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  Future<bool?> isUsernameExisted(String username) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username.toLowerCase().trim())
          .get();
      if (data.docs.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveUser(String firstName, String lastName, String email,
      String username, String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
