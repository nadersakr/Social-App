import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Friends/friends_screen.dart';
import 'package:social_app/views/screens/Home/add_post.dart';
import 'package:social_app/views/screens/Home/home_store_card.dart';
import 'package:social_app/views/screens/Home/home_tap_icon.dart';
import 'package:social_app/views/screens/Home/post.dart';
import 'package:social_app/views/screens/auth/widgets/home_drawer.dart';
import 'package:social_app/views/screens/chat/chat.dart';
import 'package:social_app/views/screens/profile_screen/friend_profile.dart';
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
    // AuthController authController = Provider.of<AuthController>(context);
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
              return const Center(child: Text("Error Occered"));
            } else {
              return SingleChildScrollView(
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
                                onPressed: () {},
                                icon: const Icon(Icons.search))
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

                    FutureBuilder(
                      future: postController.getPosts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                height: 500,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                          postController.posts.length,
                                          (i) => PostCard(
                                                postText: postController
                                                    .posts[i]['text'],
                                                press: () => Navigator.of(
                                                        context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) => FriendProfile(
                                                            friend: authControllerListenFalse
                                                                    .usersMap[
                                                                postController
                                                                        .posts[i]
                                                                    [
                                                                    'owner']]))),
                                                time: postController.posts[i]
                                                    ['time'],
                                                imageUrl: postController
                                                    .posts[i]['imageUrl'],
                                                avatarImage:
                                                    authControllerListenFalse
                                                        .usersMap[postController
                                                            .posts[i]['owner']]
                                                        ?.avatar,
                                                userName:
                                                    authControllerListenFalse
                                                        .usersMap[postController
                                                            .posts[i]['owner']]
                                                        ?.userName,
                                              )),
                                      const SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    // Add more post cards here as needed
                  ],
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: _isVisible
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPostScreen()));
                },
                child: const Icon(Icons.add),
              ),
            )
          : null,
      drawer: HomeDrawer(authController: authControllerListenFalse),
    );
  }
}
