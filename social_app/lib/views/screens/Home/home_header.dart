import 'package:flutter/material.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Home/add_post.dart';

Widget homeHeader(BuildContext context) {
  return SizedBox(
    height: 50,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Social App',
            style: TextStyle(
                color: AppColors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddPostScreen()));
              },
              icon: const Icon(
                Icons.search,
                size: 40,
              ))
        ],
      ),
    ),
  );
}
