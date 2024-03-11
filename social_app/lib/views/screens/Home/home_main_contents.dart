import 'package:flutter/material.dart';
import 'package:social_app/views/screens/Home/home_header.dart';
import 'package:social_app/views/screens/Home/home_story_card.dart';
import 'package:social_app/views/screens/Home/home_tap_buttom.dart';

import 'package:social_app/views/screens/Home/reusable_widgets.dart';

Widget homeMainContent(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        homeHeader(),
        homeStoryCards(),
        const Divider(),
        homeTapButtons(),
        const Divider(),
        const PostsFutureBuilder(),
        // Add more post cards here as needed
      ],
    ),
  );
}
