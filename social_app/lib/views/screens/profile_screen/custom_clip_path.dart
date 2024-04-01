
import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Define the start and end points of the arc
    final path = Path();
    var w = size.width;
    var h = size.height;

    path.moveTo(w * 0.65, h * 0.05); //top right
    path.lineTo(w * .93, h * 0.31); // mid top
    path.arcToPoint(
      Offset(w * 0.93, h * 0.715),
      radius: const Radius.circular(40),
    );
    path.lineTo(w * 0.93, h * 0.715); // mid bottom
    path.lineTo(w * 0.625, h * 0.98); // bottom right
    path.arcToPoint(
      Offset(w * 0.31, h * 0.93),
      radius: const Radius.circular(40),
    );
    path.lineTo(w * 0.31, h * 0.93); // bottom left
    path.lineTo(w * 0.03, h * 0.625); //  left mid bottom
    path.arcToPoint(
      Offset(w * 0.026, h * 0.365),
      radius: const Radius.circular(40),
    );
    path.lineTo(w * 0.025, h * 0.36); // left mid top

    path.lineTo(w * 0.32, h * 0.05); // top left
    path.arcToPoint(
      Offset(w * 0.65, h * 0.05),
      radius: const Radius.circular(40),
    );
    path.lineTo(w * 0.65, h * 0.05); //top right
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}