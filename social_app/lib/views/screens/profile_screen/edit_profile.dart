import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/model/edit_data_model.dart';
import 'package:social_app/views/screens/profile_screen/profile.dart';
import 'package:social_app/views/screens/profile_screen/reusable_widget_profile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late EditDataModel editDataModel;
  bool isPassword = false;
  bool isLoading = false;
  File? image;
  final imagepicker = ImagePicker();

  Future uploadImageFromGallery() async {
    //var pickedImage=await imagepicker.pickImage(source:ImageSource.camera);
    var pickedImage = await imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage!.path);
        pickedImage = File(pickedImage!.path).readAsBytesSync() as XFile?;
      });
    } else {
      return;
    }
  }

  Future uploadImageFromCamera() async {
    var pickedImage = await imagepicker.pickImage(source: ImageSource.camera);
    //  var pickedImage = await imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage!.path);
        pickedImage = File(pickedImage!.path).readAsBytesSync() as XFile?;
      });
    } else {
      return;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom * 0.2),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text(
            'Edit Profile',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_sharp),
          ),
          actions: [
            IconButton(
              color: Colors.white,
              onPressed: () {},
              icon: const Icon(Icons.settings),
            )
          ],
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                              )
                            ],
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            shape: BoxShape.circle,
                            image: image != null
                                ? DecorationImage(
                                    image: FileImage(image!),
                                    fit: BoxFit.cover,
                                  )
                                : null),
                      ),
                      if (image == null)
                        const Positioned.fill(
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.blue,
                          ),
                          child: IconButton(
                              iconSize: 18,
                              onPressed: () {
                                showDialog<String>(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Choose image from '),
                                    actions: <Widget>[
                                      Column(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              uploadImageFromCamera();
                                            },
                                            child: const Row(
                                              children: [
                                                Text('Camera',
                                                    style: TextStyle(
                                                        fontSize: 25)),
                                                Spacer(),
                                                Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 30,
                                                )
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              uploadImageFromGallery();
                                            },
                                            child: const Row(
                                              children: [
                                                Text(
                                                  'Callery',
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.camera,
                                                  size: 30,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                defaultTextFormField(
                  prefixIcon: Icons.person,
                  label: 'Full Name',
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                defaultTextFormField(
                  label: 'Email',
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  label: 'Password',
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  validate: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  prefixIcon: Icons.password_outlined,
                  suffixIcon: isPassword == false
                      ? Icons.remove_red_eye
                      : Icons.visibility_off,
                  suffixPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  isPassword: isPassword,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.cancel_outlined,
                                size: 28, color: Colors.white),
                            Text(
                              'Cancel',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo),
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.system_update,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  Text(
                                    'Saved',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ],
                              ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                              editDataModel = EditDataModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                  image: image.toString(),
                                  password: passwordController.text);
                            });

                            // Simulate loading for 1 second
                            Future.delayed(const Duration(seconds: 1), () {
                              // Perform your save operation here (e.g., update API call)
                              // ...

                              // After 1 second, update the UI
                              setState(() {
                                isLoading = false;
                                // Show the snackbar
                                final snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green,
                                  content: AwesomeSnackbarContent(
                                    title: 'Success',
                                    titleFontSize: 20,
                                    inMaterialBanner: true,
                                    message:
                                        'Profile data updated successfully',
                                    messageFontSize: 15,
                                    contentType: ContentType.success,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                // Navigate to the profile screen after showing the snackbar
                                Future.delayed(const Duration(milliseconds: 1000),
                                    () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const ProfileScreen(
                                      );
                                  }));
                                });
                              });
                            });
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
