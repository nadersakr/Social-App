// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  Widget _buildFriendRequestsSection(AuthController authcontroller) {
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
        Consumer<AuthController>(
            builder: (context, authcontroller, child) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: authcontroller.requestesfriendsMainUser.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FriendProfile(
                                friend: authcontroller
                                    .requestesfriendsMainUser[index])));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              authcontroller.requestesfriendsMainUser[index].avatar), // Display request index
                        ),
                        title: Text(authcontroller
                                .requestesfriendsMainUser[index].userName ??
                            "UserName"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check),
                              onPressed: () {
                                authcontroller.acceptedFriend(authcontroller
                                    .requestesfriendsMainUser[index].userUID!);
                                // Add logic to accept friend request
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                authcontroller.rejectRequest(authcontroller
                                    .requestesfriendsMainUser[index].userUID!);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
      ],
    );
  }

  Widget _buildAddFriendsSection(AuthController authcontroller) {
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
        Consumer<AuthController>(
            builder: (context, authcontroller, child) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: authcontroller.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FriendProfile(
                                friend: authcontroller.users[index])));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              authcontroller.users[index].avatar),
                        ),
                        title: Text('${authcontroller.users[index].userName}'),
                        trailing: IconButton(
                          icon: (authcontroller.pendingfriendsController
                                  .contains(
                                      authcontroller.users[index].userUID!))
                              ? const Icon(Icons.pending_outlined)
                              : const Icon(Icons.person_add),
                          onPressed: () async {
                            if (!(authcontroller.pendingfriendsController
                                .contains(
                                    authcontroller.users[index].userUID!))) {
                              await authcontroller
                                  .addMainUserToRequestedFriends(
                                      authcontroller.users[index].userUID!);
                            } else {
                              await authcontroller.deleteFriendFromLists(
                                  authcontroller.users[index].userUID!);
                            }
                            print("doooooooooooooooooooooooone");
                            print(AuthController.mainUser.pendingfriends);
                          },
                        ),
                      ),
                    );
                  },
                )),
      ],
    );
  }
}
