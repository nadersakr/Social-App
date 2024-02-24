import 'package:flutter/material.dart';

class StoryC extends StatelessWidget {
  const StoryC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green, body: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            child: Image.asset('assets/images/person.png'),
          ),
          const SizedBox(width: 10),
          const Text("Mohamed Hussein"),
          const SizedBox(width: 5),
          const Text("10m"),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.cancel_outlined)),
        ],
      ),);
  }
}