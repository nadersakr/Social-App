// ignore_for_file: must_be_immutable

//add post provider

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/views/screens/Home/diffrence_time.dart';

class PostCard extends StatelessWidget {
  String? avatarImage;
  int? i;
  String? userName;
  String? postText;
  String? imageUrl;
  bool? isliked;
  String? time;
  VoidCallback? press;
  VoidCallback? navigateToAddcomment;
  VoidCallback? likeFunction;
  VoidCallback? commentFunction;
  int? likesNumber;
  int? commentsNumber;
  int? sharessNumber;
  PostCard(
      {super.key,
      this.avatarImage =
          'https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg',
      this.userName = "User Name",
      required this.postText,
      required this.i,
      this.imageUrl,
      this.likeFunction,
      this.navigateToAddcomment,
      this.commentFunction,
      this.press,
      this.likesNumber = 0,
      this.commentsNumber = 0,
      this.sharessNumber = 0,
      this.isliked,
      required this.time});

  @override
  Widget build(BuildContext context) {
    final postController = Provider.of<PostController>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 211, 195, 244).withOpacity(0.2),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: press,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      avatarImage ??
                          'https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName ?? 'User Name',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        getDifferenceFromNow(time!) ?? '00',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 193, 191, 191),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: navigateToAddcomment,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  postText == null
                      ? const SizedBox(
                          height: 20,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            postText!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                  imageUrl == null
                      ? const SizedBox()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                  const SizedBox(height: 10),
                  Selector<PostController, bool>(
                      selector: (context, postController) {
                    if (postController.posts[i!]['isLiked'] != null) {
                      return postController.posts[i!]['isLiked'];
                    } else {
                      return false;
                    }
                  }, builder: (context, liked, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: likeFunction,
                              icon: const Icon(Icons.thumb_up),
                              color: (liked)
                                  ? const Color.fromARGB(255, 208, 157, 255)
                                  : const Color.fromARGB(255, 192, 191, 191),
                            ),
                            InkWell(
                                onTap: () {},
                                child: Text(
                                    "${postController.posts[i!]['likers']?.length ?? 0}"))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.comment),
                            const SizedBox(
                              width: 8,
                            ),
                            Text("$commentsNumber")
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
