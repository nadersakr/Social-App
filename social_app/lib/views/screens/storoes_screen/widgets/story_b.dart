import 'package:flutter/material.dart';

class StoryB extends StatelessWidget {
  const StoryB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Row(
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
      ),
    );
  }
}
