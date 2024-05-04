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
            future: userViewModel.loadingMyUserDataToUserModel(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else {
                return Text("${snapshot.data!.mail}");
              }
            }),
      ),
    );
  }
}
