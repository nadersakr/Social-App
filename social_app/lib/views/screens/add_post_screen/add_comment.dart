import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/provider/post_provider.dart';

class AddComment extends StatefulWidget {
  final Map<String, dynamic> post;
  const AddComment({super.key, required this.post});
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Provider.of<AuthController>(context);
    final PostController postController = Provider.of<PostController>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.76,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                // show comments of the post
                child: Column(children: [
                  if (widget.post['text'] != null)
                    Text(
                      widget.post['text'],
                      style: const TextStyle(fontSize: 20),
                    ),
                  if (widget.post['imageUrl'] != null)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.post['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Text('Comments'),
                  Container(
                    color: Colors.amber,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (widget.post['comments'] != null)
                            ...List.generate(
                              widget.post['comments'].length,
                              (index) {
                                return FutureBuilder(
                                  future: authController.fromUIDToMainUser(
                                      widget.post['comments'][index]
                                          ['commenter']),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              snapshot.data.avatar),
                                        ),
                                        title: Text(snapshot.data.userName),
                                        subtitle: Text(widget.post['comments']
                                                [index]['comment'] ??
                                            "No Comment"),
                                      );
                                    }
                                  },
                                );
                              },
                            )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      if (_commentController.text.isNotEmpty) {
                        await postController.addComment(
                          comment: _commentController.text,
                          commenter: authController.mainUser.userUID!,
                          post: widget.post,
                        );
                        Navigator.of(context).pop();

                        _commentController.clear();
                      }
                    },
                  ),
                ],
              ),
              // TextField(

              //   controller: _commentController,
              //   maxLines: null,
              //   decoration: const InputDecoration(
              //     hintText: 'Add a comment',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(10)),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
