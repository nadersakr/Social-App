import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_app/views/screens/storoes_screen/story_progress_bars.dart';
import 'package:social_app/views/screens/storoes_screen/widgets/sory_a.dart';
import 'package:social_app/views/screens/storoes_screen/widgets/story_b.dart';
import 'package:social_app/views/screens/storoes_screen/widgets/story_c.dart';

class OpenStory extends StatefulWidget {
  const OpenStory({super.key});
  static const routName = "openStory";

  @override
  State<OpenStory> createState() => _OpenStoryState();
}

class _OpenStoryState extends State<OpenStory> {
  int currentStoryIndex = 0;
  List<double> precentValue = [];
  List<Widget> stories = [
    const StoryA(),
    const StoryB(),
    const StoryC(),
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < stories.length; i++) {
      precentValue.add(0);
    }
    startWatched();
  }

  void startWatched() {
    Timer.periodic(
    const  Duration(milliseconds: 50),
      (timer) {
        setState(() {
          if (precentValue[currentStoryIndex] + 0.01 < 1) {
            precentValue[currentStoryIndex] += 0.01;
          } else {
            precentValue[currentStoryIndex] = 1;
            timer.cancel();
            if (currentStoryIndex < stories.length - 1) {
              currentStoryIndex++;
              startWatched();
            } else {
              Navigator.of(context).pop();
            }
          }
        });
      },
    );
  }

  void onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < (screenWidth / 2)) {
      setState(() {
        if (currentStoryIndex > 0) {
          precentValue[currentStoryIndex - 1] = 0;
          precentValue[currentStoryIndex] = 0;
          currentStoryIndex--;
        }
      });
    } else {
      setState(() {
        if (currentStoryIndex < stories.length - 1) {
          precentValue[currentStoryIndex] = 1;
          currentStoryIndex++;
        } else {
          precentValue[currentStoryIndex] = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      child: Scaffold(
        body: Stack(children: [
          stories[currentStoryIndex],
          StoryProgressBar(precentValue: precentValue),
        ]),
      ),
    );
  }
}
