import 'package:flutter/material.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/views/screens/Home/post.dart';
import 'package:social_app/views/screens/profile_screen/friend_profile.dart';

class PostsFutureBuilder extends StatelessWidget {
  final PostController postController;
  final AuthController authController;

const PostsFutureBuilder({super.key, required this.postController, required this.authController});

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    children: [
                      ...List.generate(
                          postController.posts.length,
                          (i) => PostCard(
                            postText: postController.posts[i]['text'],
                            press: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FriendProfile(
                                  friend: authController.usersMap[postController.posts[i]['owner']],
                                ),
                              ),
                            ),
                            time: postController.posts[i]['time'], // Add the 'time' argument here
                            imageUrl: postController.posts[i]['imageUrl'],
                            avatarImage: authController.usersMap[postController.posts[i]['owner']]?.avatar,
                            userName: authController.usersMap[postController.posts[i]['owner']]?.userName,
                          
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
    );
  }
}