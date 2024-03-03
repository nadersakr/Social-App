import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/views/screens/profile_screen/friend_profile.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        // Pass your Future function to the future parameter
        future: authController.getFriends(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          // Check the connection state of the Future
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // If the Future is completed, return your screen's widget tree
            return Center(
              child: ListView(
                children: [
                  _buildFriendRequestsSection(authController),
    
                  _buildAddFriendsSection(authController),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFriendRequestsSection(AuthController authController) {
    List<MainUser> friendRequests = 

    
    [
   ...?authController.mainUser!.requestesfriends
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Friend Requests',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: friendRequests.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    '${friendRequests[index].avatar}'), // Display request index
              ),
              title: Text(friendRequests[index].userName ?? "UserName"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      // Add logic to accept friend request
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // Add logic to reject friend request
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAddFriendsSection(AuthController authController) {
    List<MainUser?> suggestedUsers = [...authController.friends,];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Add Friends',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: suggestedUsers.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FriendProfile(
                        friend: suggestedUsers[index] ??
                            authController.mainUser)));
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage('${suggestedUsers[index]?.avatar}'),
                ),
                title: Text('${suggestedUsers[index]?.userName}'),
                trailing: IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: () {
                    // Add logic to add the user as a friend
                    // This can include sending a friend request, updating database, etc.
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
