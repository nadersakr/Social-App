import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  _AddStoryScreenState createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
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
      body: Center(
          child: _image == null
              ? const Text('No image selected.')
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      image: DecorationImage(
                        image: FileImage(File(_image!.path)),
                        fit: BoxFit.fitWidth,
                      )),
                  width: MediaQuery.of(context).size.width,
                )),
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
