import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/views/screens/Home/home_header.dart';
import 'package:social_app/views/screens/Home/home_story_card.dart';


import 'package:social_app/views/screens/Home/reusable_widgets.dart';

Widget homeMainContent(BuildContext context) {
  return SingleChildScrollView(
    child: Stack(
      children: [
        SvgPicture.asset('assets/svg/home.svg'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            homeHeader(context),
            homeStoryCards(context),
            const Divider(),
            // homeTapButtons(),
            // const Divider(),
            const PostsFutureBuilder(),
            // Add more post cards here as needed
          ],
        ),
      ],
    ),
  );
}
