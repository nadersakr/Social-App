import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  // get user data from the database (firebase firestore)
  void searchUserData(String value) {
    // code to search user data

    var user = FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: value)
        .get();
    user.then((value) {
      print(value.docs[0].data());
    });
  }
}
