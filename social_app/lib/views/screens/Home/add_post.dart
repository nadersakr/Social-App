import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _postController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    String amPm = now.hour >= 12 ? 'PM' : 'AM';

    // Convert hour to 12-hour format
    int hour = now.hour % 12;
    if (hour == 0) {
      hour = 12; // For midnight, use 12
    }
    AuthController authController = Provider.of<AuthController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _postController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'What\'s on your mind?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Image'),
            ),
            if (_image != null)
              Image.file(
                _image!,
                fit: BoxFit.cover,
                height: 200,
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostPreviewScreen(
                      text: _postController.text,
                      image: _image,
                    ),
                  ),
                );
              },
              child: const Text('Preview Post'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_image != null || _postController.text != '') {
                  showDialog(
                    context: context,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  var storage = FirebaseFirestore.instance;
                  var posts = storage.collection("posts");

                  // Upload image to Firebase Storage
                  String? imageUrl;
                  if (_image != null) {
                    try {
                      // Create a reference to the file location in Firebase Storage
                      Reference ref = FirebaseStorage.instance.ref().child(
                            'posts/${path.basename(_image!.path)}',
                          );

                      // Upload the file to Firebase Storage
                      await ref.putFile(_image!);

                      // Get the download URL
                      imageUrl = await ref.getDownloadURL();
                    } catch (e) {
                      print(e);
                      // Handle any errors
                    }
                  }

                  // Add the post document with the image URL
                  await posts.add({
                    'owner': authController.mainUser.userUID,
                    'text': _postController.text == ''
                        ? null
                        : _postController.text,
                    'time':
                        '${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $amPm, ${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString().padLeft(2, '0')}',
                    'imageUrl': imageUrl, // Add the image URL to the document
                  });

                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(context).pop();
                }
                print(_postController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostPreviewScreen extends StatelessWidget {
  final String text;
  final File? image;

  const PostPreviewScreen({super.key, required this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Preview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(text),
            if (image != null)
              Image.file(
                image!,
                fit: BoxFit.cover,
                height: 200,
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle post submission
                print('Post submitted: $text');
                Navigator.pop(context);
              },
              child: const Text('Submit Post'),
            ),
          ],
        ),
      ),
    );
  }
}
