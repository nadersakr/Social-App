import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/views/screens/add_post_screen/post.dart';
import 'package:social_app/views/screens/profile_screen/friend_profile.dart';

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
        Provider.of<AuthController>(context, listen: true);
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
                  child: Selector<AuthController, int>(
                    selector: (context, authController) =>
                        authController.mainUser.friends!.length,
                    builder: (context, friendsCount, child) {
                      print(
                          "selector for friends---------------------------------");

                      return Column(
                        children: [
                          ...List.generate(
                              postController.posts.length,
                              (i) => Selector<PostController, int>(
                                    selector: (context, postController) {
                                      if (postController.posts[i]['likers'] !=
                                          null) {
                                        return postController
                                            .posts[i]['likers']?.length;
                                      } else {
                                        return 0;
                                      }
                                    },
                                    builder: (context, likersCount, child) {
                                      print(
                                          "selector for likes---------------------------------");
                                      return PostCard(
                                          postText: postController.posts[i]
                                              ['text'],
                                          press: () =>
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FriendProfile(
                                                    friend: authController
                                                            .usersMap[
                                                        postController.posts[i]
                                                            ['owner']]!,
                                                  ),
                                                ),
                                              ),
                                          time: postController.posts[i][
                                              'time'], // Add the 'time' argument here
                                          imageUrl: postController.posts[i]
                                              ['imageUrl'],
                                          isliked: (postController.posts[i]['likers'] ?? []).contains(
                                              authController.mainUser.userUID),
                                          avatarImage: authController
                                              .usersMap[postController.posts[i]
                                                  ['owner']]
                                              ?.avatar,
                                          userName: authController
                                              .usersMap[postController.posts[i]
                                                  ['owner']]
                                              ?.userName,
                                          likesNumber:
                                              (postController.posts[i]['likers'] ?? [])
                                                  .length,
                                          likeFunction: () async {
                                            await postController.likePost(
                                                liker: authController
                                                    .mainUser.userUID!,
                                                post: postController.posts[i]);
                                          });
                                    },
                                  )),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    },
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
