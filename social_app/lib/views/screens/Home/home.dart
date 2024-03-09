import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';
import 'package:social_app/views/screens/auth/widgets/home_drawer.dart';
import 'package:social_app/provider/auth/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _scrollController.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _isVisible = true;
      });
    } else {
      setState(() {
        _isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("homeeeeeeeee rebuild");
    AuthController authControllerListenFalse =
        Provider.of<AuthController>(context, listen: false);
    PostController postController =
        Provider.of<PostController>(context, listen: false);
    return Scaffold(
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
              return homeMainContent(
                  context);
            }
          },
        ),
      ),
      floatingActionButton:
          _isVisible ? homeFloatingActionButton(context) : null,
      drawer: HomeDrawer(authController: authControllerListenFalse),
    );
  }
}
