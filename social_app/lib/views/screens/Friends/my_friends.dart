import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';

class MyFriends extends StatelessWidget {
  const MyFriends({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the AuthController from the Provider
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('myFriends List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: authController.myFriends.isNotEmpty
          ? ListView.separated(
              itemCount: authController.myFriends.length,
              itemBuilder: (context, index) {
                // Assuming each friend is a Map<String, dynamic> with 'name', 'email', and 'avatar' keys
                final friend = authController.myFriends[index];
                print(friend);
                print('========================================================');
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(friend.avatar!),
                      ),
                  title: Text(
                    friend.userName!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(friend.email!),
                  trailing: IconButton(
                    icon: const Icon(Icons.chat),
                    onPressed: () {
                      // Handle chat button press
                    },
                  ),
                  onTap: () {
                    // Navigate to friend's profile or chat screen
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(color: Colors.grey),
            )
          : const Center(child: Text('No myFriends found')),
    );
  }
}