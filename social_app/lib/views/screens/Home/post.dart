import 'package:flutter/material.dart';
class PostCard extends StatelessWidget {
  String? avatarImage;
  String? userName;
  String? postText;
  String? imageUrl;
  String? time;
  VoidCallback? press;
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
      this.imageUrl,this.likeFunction,this.commentFunction,
      
      this.press,
      this.likesNumber = 0,
      this.commentsNumber = 0,
      this.sharessNumber = 0,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 150, 120, 210).withOpacity(0.2),
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
                        time ?? '00',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            postText == null
                ? const SizedBox()
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
                : Image.network(
                    imageUrl!,
                    fit: BoxFit.fill,
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
                        onPressed: likeFunction, icon: const Icon(Icons.thumb_up)),
                    InkWell(onTap: () {}, child: Text("$likesNumber"))
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: commentFunction, icon: const Icon(Icons.comment)),
                    InkWell(onTap: () {}, child: Text("$commentsNumber"))
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
