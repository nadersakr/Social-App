import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String name;
  final String username;
  final String avatarUrl;

  User({required this.name, required this.username, required this.avatarUrl});
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<User>> _searchUsers() async {
    final querySnapshot = await _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: _searchQuery)
        .get();

    return querySnapshot.docs.map((doc) {
      return User(
        name: doc['firstName'],
        username: doc['username'],
        avatarUrl: "sna",
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'search',
            ),
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<User>>(
            future: _searchUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final users = snapshot.data ?? [];
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatarUrl),
                      ),
                      title: Text(user.name),
                      subtitle: Text('@${user.username}'),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
