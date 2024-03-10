import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Friends/friends_screen.dart';
import 'package:social_app/views/screens/Home/add_post.dart';
import 'package:social_app/views/screens/Home/home_store_card.dart';
import 'package:social_app/views/screens/Home/home_tap_icon.dart';
import 'package:social_app/views/screens/add_post_screen/post.dart';
import 'package:social_app/views/screens/chat/chats.dart';
import 'package:social_app/views/screens/profile_screen/friend_profile.dart';
import 'package:social_app/views/screens/profile_screen/profile.dart';

// This widget is responsible for fetching and displaying posts from the server.
class PostsFutureBuilder extends StatefulWidget {
  const PostsFutureBuilder({super.key});

  @override
  State<PostsFutureBuilder> createState() => _PostsFutureBuilderState();
}

class _PostsFutureBuilderState extends State<PostsFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    final AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    final PostController postController =
        Provider.of<PostController>(context, listen: false);
    return FutureBuilder(
      future: postController.getPosts(authController.mainUser),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // handle the case when data is successfully fetched
          return Column(
            children: [
              SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  child: Consumer<PostController>(
                    builder: (context, postController, child) => Column(
                      children: [
                        ...List.generate(
                            postController.posts.length,
                            (i) => PostCard(
                                postText: postController.posts[i]['text'],
                                press: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => FriendProfile(
                                          friend: authController.usersMap[
                                              postController.posts[i]
                                                  ['owner']]!,
                                        ),
                                      ),
                                    ),
                                time: postController.posts[i]
                                    ['time'], // Add the 'time' argument here
                                imageUrl: postController.posts[i]['imageUrl'],
                                isliked: (postController.posts[i]['likers'] ??
                                        [])
                                    .contains(authController.mainUser.userUID),
                                avatarImage: authController
                                    .usersMap[postController.posts[i]['owner']]
                                    ?.avatar,
                                userName: authController
                                    .usersMap[postController.posts[i]['owner']]
                                    ?.userName,
                                likesNumber:
                                    (postController.posts[i]['likers'] ?? [])
                                        .length,
                                likeFunction: () async {
                                  setState(() async {
                                    await postController.likePost(
                                        liker: authController.mainUser.userUID!,
                                        post: postController.posts[i]);
                                  });
                                })),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

// This widget is a floating action button for adding new posts.
Widget homeFloatingActionButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddPostScreen()));
      },
      child: const Icon(Icons.add),
    ),
  );
}

// This widget contains the main navigation buttons for the home screen.
Widget homeTapButtons() {
  return const SizedBox(
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TapButton(
          widget: FriendsScreen(),
          icon: Icon(Icons.people_outline_rounded),
        ),
        TapButton(
          widget: ChatsScreen(),
          icon: Icon(Icons.chat_bubble_outline_rounded),
        ),
        TapButton(
          widget: ProfileScreen(),
          icon: Icon(Icons.person),
        ),
      ],
    ),
  );
}

// This widget displays the story cards on the home screen.
Widget homeStoryCards() {
  return SizedBox(
    height: 100,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        StoryCard(),
      ],
    ),
  );
}

// This widget displays the header of the home screen.
Widget homeHeader() {
  return SizedBox(
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
    ),
  );
}

// This widget is the main content of the home screen, including the header, story cards, navigation buttons, and posts.
Widget homeMainContent(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        homeHeader(),
        homeStoryCards(),
        const Divider(),
        homeTapButtons(),
        const Divider(),
        const PostsFutureBuilder(),
        // Add more post cards here as needed
      ],
    ),
  );
}
