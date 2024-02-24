import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});
  static const addImage = "uploadImage";

  @override
  State<AddImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<AddImage> {
  File? image;
  final ImagePicker imagePicker = ImagePicker();
  uploadImageFromGallary() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  uploadImageFromCamera() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        isVisibility = false;
      });
    }
  }

  // FloatingActionButton
   bool isVisibility = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadImageFromCamera();
          setState(() {
            isVisibility = false;
          });
        },
        child:const Icon(Icons.camera_alt),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          if (isVisibility)
            Center(
              child: MaterialButton(
                color: Colors.green,
                onPressed: () {
                  uploadImageFromGallary();
                  setState(() {
                    isVisibility = false;
                  });
                },
                child:const Text("Upload Image from gallary"),
              ),
            ),
          image == null
              ? const Text("Not Picked Image")
              : Image.file(
                  image!,
                  fit: BoxFit.cover,
                ),
        ]),
      ),
    );
  }
}
