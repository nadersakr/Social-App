import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyPresentProgressBar extends StatelessWidget {
  final double precentValue;
  const MyPresentProgressBar({super.key, required this.precentValue});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight:  10,
      percent: precentValue,
      progressColor: Colors.white,
      backgroundColor: Colors.grey,
    );
  }
}


