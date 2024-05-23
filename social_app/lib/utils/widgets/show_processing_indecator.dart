import 'package:flutter/material.dart';

class ShowIndecator {
  void showCircularProgress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void disposeTheShownWidget(BuildContext context) {
    Navigator.of(context).pop();
  }

  void showSnackBar(BuildContext context, String message,
      {TypeSnackBar? typeSnackBar}) {
    late Color color;
    switch (typeSnackBar) {
      case TypeSnackBar.error:
        color = Colors.red;

        break;
      case TypeSnackBar.success:
        color = Colors.green;

        break;
      case TypeSnackBar.warning:
        color = Colors.orange;

        break;
      case TypeSnackBar.info:
        color = Colors.blue;

        break;

      default:
        color = Colors.blue;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}

enum TypeSnackBar {
  error,
  success,
  warning,
  info,
}
