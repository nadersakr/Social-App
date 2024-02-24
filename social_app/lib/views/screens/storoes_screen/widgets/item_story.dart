import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  const StoryCircle({ required this.function, super.key});
  final Function() function;
   
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
