import 'package:flutter/material.dart';
import 'package:social_app/views/screens/Friends/friends_screen.dart';
import 'package:social_app/views/screens/Home/home.dart';
import 'package:social_app/views/screens/Home/home_tap_icon.dart';
import 'package:social_app/views/screens/chat/chats.dart';
import 'package:social_app/views/screens/profile_screen/profile.dart';

Widget homeTapButtons() {
  return const SizedBox(
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TapButton(
          widget: HomeScreen(),
          icon: Icon(Icons.menu),
        ),
        TapButton(
          widget: FriendsScreen(),
          icon: Icon(Icons.people_outline_rounded),
        ),
        TapButton(
          widget: ChatsScreen(),
          icon: Icon(Icons.chat_bubble_outline_rounded),
        ),
        TapButton(
          widget: ProfileScreen(),
          icon: Icon(Icons.person),
        ),
        TapButton(
          widget: HomeScreen(),
          icon: Icon(Icons.home_outlined),
        ),
      ],
    ),
  );
}
