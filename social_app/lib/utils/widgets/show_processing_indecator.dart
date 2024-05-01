import 'package:flutter/material.dart';

class ShowIndecator {

 static void showCircularProgress(BuildContext context) {
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
  static void disposeTheShownWidget(BuildContext context) {
   Navigator.of(context).pop();
          
  }
}