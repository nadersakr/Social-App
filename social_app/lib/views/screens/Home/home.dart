import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Friends/friends_screen.dart';
import 'package:social_app/views/screens/Home/home_store_card.dart';
import 'package:social_app/views/screens/Home/home_tap_icon.dart';
import 'package:social_app/views/screens/Home/post.dart';
import 'package:social_app/views/screens/auth/widgets/home_drawer.dart';
import 'package:social_app/views/screens/chat/chat.dart';
import 'package:social_app/views/screens/profile_screen/profile.dart';
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

      AuthController authController =
          Provider.of<AuthController>(context, listen: false);
      await authController.setUser();
      await authController.getdata();
      authController.setTextControler();
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
    AuthController authController = Provider.of<AuthController>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Social App',
                        style: TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    StoryCard(),
                  ],
                ),
              ),
              const Divider(),
               const SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TapButton(
                      widget: FriendsScreen(),
                      icon: Icon(Icons.people_outline_rounded),
                    ),
                    TapButton(
                      widget: ChatScreen(),
                      icon: Icon(Icons.chat_bubble_outline_rounded),
                    ),
                    TapButton(
                      widget: ProfileScreen(),
                      icon: Icon(Icons.person),
                    ),
                  ],
                ),
              ),
              const Divider(),
              PostCard(
                  avatarImage:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYscfUBUbqwGd_DHVhG-ZjCOD7MUpxp4uhNe7toUg4ug&s',
                  userName: 'aaa',
                  postText: "${authController.mainUser?.email}",
                  imageUrl: 'https://via.placeholder.com/300',
                  likesNumber: 24,
                  commentsNumber: 48,
                  sharessNumber: 3,
                  time: 'Posted 2 hours ago'),
              const Divider(),
              PostCard(
                  avatarImage:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYscfUBUbqwGd_DHVhG-ZjCOD7MUpxp4uhNe7toUg4ug&s',
                  userName: 'aaa',
                  postText: "${authController.mainUser?.email}",
                  imageUrl: 'https://via.placeholder.com/300',
                  likesNumber: 24,
                  commentsNumber: 48,
                  sharessNumber: 3,
                  time: 'Posted 2 hours ago'),
              const Divider(),
              PostCard(
                  avatarImage:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYscfUBUbqwGd_DHVhG-ZjCOD7MUpxp4uhNe7toUg4ug&s',
                  userName: 'aaa',
                  postText: "${authController.mainUser?.email}",
                  imageUrl: 'https://via.placeholder.com/300',
                  likesNumber: 24,
                  commentsNumber: 48,
                  sharessNumber: 3,
                  time: 'Posted 2 hours ago'),
              const Divider(),

              // Add more post cards here as needed
            ],
          ),
        ),
      ),
      floatingActionButton: _isVisible
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            )
          : null,
      drawer: HomeDrawer(authController: authController),
    );
  }
}
