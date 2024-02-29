import 'package:flutter/material.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/utils/shared-preferences/shared_preferences.dart';
import 'package:social_app/views/screens/auth/login/login_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.authController,
  });

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.blue,
            ),
            accountName: Text(
              'User Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              'user@example.com',
            ),
            currentAccountPicture: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYscfUBUbqwGd_DHVhG-ZjCOD7MUpxp4uhNe7toUg4ug&s',
              ),
            ),
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.person),
            onTap: () {
              // Navigate to user profile
            },
          ),
          ListTile(
            title: const Text('Chats'),
            leading: const Icon(Icons.chat_bubble_outline_rounded),
            onTap: () {
              // Navigate to settings
            },
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              try {
                authController.signout();
                AppSharedPreferences.setbool(key: "islogin", value: false);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              } catch (e) {
                // print(e);
              }
              // Implement logout functionality
            },
          ),
        ],
      ),
    );
  }
}
