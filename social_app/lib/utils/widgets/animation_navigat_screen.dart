import 'package:flutter/material.dart';

class AnimationNavigatScreen extends PageRouteBuilder {
  final Widget page;

  AnimationNavigatScreen(this.page,)
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 0.0);
            var end = const Offset(0.0, 0.0);
            // var curve = Curves.ease;

            // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var tween = Tween(begin: begin, end: end);

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) => page,
        );
}