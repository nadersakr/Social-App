import 'package:flutter/material.dart';
import 'package:social_app/utils/colors.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.blue, width: 2),
          image: const DecorationImage(
            image: NetworkImage(
              'https://via.placeholder.com/150',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}