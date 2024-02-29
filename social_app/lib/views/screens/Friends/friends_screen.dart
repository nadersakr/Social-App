import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          _buildFriendRequestsSection(), 
          // _buildFriendSuggestionsSection(), 
          _buildAddFriendsSection(),
        ],
      ),
    );
  }

  Widget _buildFriendRequestsSection() {

    List<String> friendRequests = [
      'Friend Request 1',
      'Friend Request 2',
      'Friend Request 3',
      'Friend Request 4',
      'Friend Request 5',
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
                child: Text((index + 1).toString()), // Display request index
              ),
              title: Text(friendRequests[index]),
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

  // Widget _buildFriendSuggestionsSection() {
  //   return ListTile(
  //     title: Text('Friend Suggestions'),
  //     // Implement logic to display friend suggestions
  //     // You can use a ListView.builder or any other suitable widget
  //   );
  // }

  Widget _buildAddFriendsSection() {
    List<String> suggestedUsers = [
      'User 1',
      'User 2',
      'User 3',
      'User 4',
      'User 5',
    ];
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
            return ListTile(
              leading: CircleAvatar(
                child: Text((index + 1).toString()), 
              ),
              title: Text(suggestedUsers[index]),
              trailing: IconButton(
                icon: const Icon(Icons.person_add),
                onPressed: () {
                  // Add logic to add the user as a friend
                  // This can include sending a friend request, updating database, etc.
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
