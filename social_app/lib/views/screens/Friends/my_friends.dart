import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/views/screens/profile_screen/friend_profile.dart';

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
                print(
                    '========================================================');
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(friend.avatar!),
                  ),
                  title: Text(
                    friend.userName!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(friend.email!),
                  trailing: SizedBox(
                    width: 95.w,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chat),
                          onPressed: () {
                            // Handle chat button press
                          },
                        ),
                        IconButton(
 icon: const Icon(Icons.remove_circle_outline),
 onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Friend'),
          content: const Text('Are you sure you want to remove this friend?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                // Call the function to remove the friend
                authController.removeFriend(friend);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
 },
),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FriendProfile(friend: friend)));
                  },
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey),
            )
          : const Center(child: Text('No myFriends found')),
    );
  }
}
