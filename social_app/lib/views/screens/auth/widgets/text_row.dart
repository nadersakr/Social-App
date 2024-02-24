import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final String textButton;
  const TextRow({
    super.key,
    required this.text,
    required this.textButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              textButton,
              style: const TextStyle(fontSize: 18),
            ))
      ],
    );
  }
}