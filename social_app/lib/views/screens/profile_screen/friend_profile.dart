import 'package:flutter/material.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/views/screens/chat/chat_screen.dart';

class FriendProfile extends StatelessWidget {
  final MainUser friend;
  const FriendProfile({super.key, required this.friend});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            resevier: friend,
                          )));
            },
            icon: const Icon(
              Icons.chat,
              size: 28,
            )),
        const SizedBox(
          width: 15,
        )
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                  friend.avatar,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                friend.userName ?? "User Name",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                '${friend.bio}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('About Me'),
            const SizedBox(height: 10),
            Text(
              '${friend.aboutMe}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Contact Information'),
            const SizedBox(height: 10),
            _buildContactInfoTile(
                Icons.email, 'Email', friend.email ?? "user@example.com"),
            _buildContactInfoTile(Icons.phone, 'Phone', '${friend.phone}'),
            _buildContactInfoTile(
                Icons.location_on, 'Address', '${friend.address}'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContactInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
