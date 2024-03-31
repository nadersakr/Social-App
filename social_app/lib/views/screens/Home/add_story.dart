import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/helper/animation.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  AddStoryScreenState createState() => AddStoryScreenState();
}

class AddStoryScreenState extends State<AddStoryScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Story'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: getImage,
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _image == null
                ? AnimationLoder(
                    animated: 'assets/animation/wired-gradient-61-camera.json',
                    width: MediaQuery.of(context).size.width * 0.6,
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        image: DecorationImage(
                          image: FileImage(File(_image!.path)),
                          fit: BoxFit.fitWidth,
                        )),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height *
                        0.5, // Add this line
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement save story functionality
        },
        tooltip: 'Save Story',
        child: const Icon(Icons.save),
      ),
    );
  }
}
