import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/views/screens/Home/diffrence_time.dart';

class PreviewPostPage extends StatefulWidget {
  final Map<String, dynamic> post;
  const PreviewPostPage({super.key, required this.post});

  @override
  _PreviewPostPageState createState() => _PreviewPostPageState();
}

class _PreviewPostPageState extends State<PreviewPostPage> {
  bool _isExpanded = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PostController postController = Provider.of<PostController>(context);
    AuthController authController = Provider.of<AuthController>(context);
    print("widget.post['time'] ${widget.post['time']}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Post'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.848,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(authController
                            .usersMap[widget.post['owner']]!.avatar!),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authController
                                .usersMap[widget.post['owner']]!.userName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            getDifferenceFromNow(widget.post['time']),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // Display the image or an empty circular container
                  if (widget.post['imageUrl'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(widget.post['imageUrl']),
                    ),

                  const SizedBox(height: 16.0),
                  Text(
                    _isExpanded
                        ? widget.post['text']
                        : _getShortenedContent(widget.post['text'] ?? ''),
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  if ((widget.post['text'] ?? "").length > 40)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? 'Show less' : 'Show more',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16.0),

                  const Text(
                    'Comments:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: ListView.builder(
                        itemCount: (widget.post['comments'] ?? []).length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: authController.fromUIDToMainUser(
                                widget.post['comments'][index]['commenter']),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(snapshot.data.avatar),
                                  ),
                                  title: Text(snapshot.data.userName),
                                  subtitle: Text(widget.post['comments'][index]
                                          ['comment'] ??
                                      "No Comment"),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _commentController,
                          decoration: const InputDecoration(
                            hintText: 'Add a comment...',
                            border: OutlineInputBorder(),
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
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  

  String _getShortenedContent(String content) {
    if (content.length > 40) {
      return '${content.substring(0, 40)}...';
    }
    return content;
  }
}
