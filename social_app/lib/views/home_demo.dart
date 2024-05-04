import 'package:flutter/material.dart';
import 'package:social_app/view_model/user_viewmodel.dart';

class HomeDemo extends StatelessWidget {
  const HomeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = UserViewModel();
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: userViewModel.loadingMyUserData(),
            builder: (context, snapshot) {
              return const Text('Home Screen Demo',
                  style: TextStyle(fontSize: 30));
            }),
      ),
    );
  }
}
