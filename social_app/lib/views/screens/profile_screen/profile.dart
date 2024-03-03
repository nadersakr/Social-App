import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/views/screens/Friends/my_friends.dart';
import 'package:social_app/views/screens/profile_screen/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  const MyFriends()));
            },
            icon: const Icon(
              Icons.people,
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
                  authController.mainUser.avatar!,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                authController.mainUser.userName ?? "User Name",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                '${authController.mainUser.bio}',
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
              '${authController.mainUser.aboutMe}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Contact Information'),
            const SizedBox(height: 10),
            _buildContactInfoTile(Icons.email, 'Email',
                authController.mainUser.email ?? "user@example.com"),
            _buildContactInfoTile(
                Icons.phone, 'Phone', '${authController.mainUser.phone}'),
            _buildContactInfoTile(Icons.location_on, 'Address',
                '${authController.mainUser.address}'),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()));
          },
          child: const Icon(Icons.edit),
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
