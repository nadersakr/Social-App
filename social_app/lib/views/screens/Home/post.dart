import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String avatarImage;
  final String userName;
  final String postText;
  final String imageUrl;
  final String time;
  final int likesNumber;
  final int commentsNumber;
  final int sharessNumber;
  const PostCard(
      {super.key,
      required this.avatarImage,
      required this.userName,
      required this.postText,
      required this.imageUrl,
      required this.likesNumber,
      required this.commentsNumber,
      required this.sharessNumber,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    avatarImage,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              postText,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.thumb_up)),
                    InkWell(onTap: () {}, child: Text("$likesNumber"))
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.comment)),
                    InkWell(onTap: () {}, child: Text("$commentsNumber"))
                  ],
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                    InkWell(onTap: () {}, child: Text("$sharessNumber"))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}