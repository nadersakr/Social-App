import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/views/screens/Home/home_main_contents.dart';
import 'package:social_app/views/screens/auth/widgets/home_drawer.dart';
import 'package:social_app/provider/auth/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    print("homeeeeeeeee rebuild");
    AuthController authControllerListenFalse =
        Provider.of<AuthController>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: authControllerListenFalse.getAppData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error Occured"));
              } else {
                return homeMainContent(context);
              }
            },
          ),
        ),
        
        drawer: HomeDrawer(authController: authControllerListenFalse),
      ),
    );
  }
}
