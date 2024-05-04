import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/model/user_model_.dart';

class FirebasefirestoreLoadUserData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserModel> loadAUserData(String uid) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(uid).get();
    return UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }

}
