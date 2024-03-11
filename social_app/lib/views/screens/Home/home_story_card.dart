import 'package:flutter/material.dart';
import 'package:social_app/views/screens/Home/home_store_card.dart';

Widget homeStoryCards() {
  return SizedBox(
    height: 100,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        StoryCard(),
      ],
    ),
  );
}