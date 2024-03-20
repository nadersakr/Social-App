import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationLoder extends StatelessWidget {
  final String animated;
  final double width;
 
  const AnimationLoder(
      {super.key, required this.animated, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          animated,
          width: width,
          
          fit: BoxFit.fill,
        )
      ],
    );
  }
}
