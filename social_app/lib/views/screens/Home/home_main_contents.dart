import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/view_model/user_viewmodel.dart';
import 'package:social_app/views/screens/Home/home_header.dart';
import 'package:social_app/views/screens/Home/home_story_card.dart';

Widget homeMainContent(BuildContext context) {
  UserViewModel userViewModel = UserViewModel();
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
            FutureBuilder(
            future: userViewModel.loadingMyUserDataToUserModel(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else {
                return Text("${snapshot.data!.mail}");
              }
            })
            // const PostsFutureBuilder(),
            // Add more post cards here as needed
          ],
        ),
      ],
    ),
  );
}
