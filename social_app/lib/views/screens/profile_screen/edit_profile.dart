import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/auth/widgets/custom_text_field.dart';
import 'package:social_app/views/screens/profile_screen/profile.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: authController.formKeyEditProfile,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundImage: authController.imageFile != null
                          ? FileImage(authController.imageFile!)
                          : const NetworkImage("https://via.placeholder.com/60")
                              as ImageProvider),
                  CircleAvatar(
                    backgroundColor: AppColors.blue,
                    child: IconButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          authController.addFileImage(image);
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: authController.userNameSignUpController,
                hintText: 'username',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "username is required";
                  } else if (value.length < 4) {
                    return "username must be more than 3 characters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: authController.bioProfileController,
                hintText: 'Bio',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Bio is required";
                  } else if (value.length < 4) {
                    return "Bio must be more than 3 characters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: authController.aboutMeProfileController,
                hintText: 'Aboutme',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Aboutme is required";
                  } else if (value.length < 4) {
                    return "Aboutme must be more than 3 characters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: authController.phoneProfileController,
                hintText: 'phone',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "phone is required";
                  } else if (value.length < 4) {
                    return "phone must be more than 3 characters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                controller: authController.addressProfileController,
                hintText: 'address',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "address is required";
                  } else if (value.length < 5) {
                    return "address must be more than 4 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (authController.formKeyEditProfile.currentState!
                        .validate()) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(authController.mainUser?.userUID)
                          .set({
                        'username':
                            authController.userNameSignUpController.text,
                        'bio': authController.bioProfileController.text,
                        'aboutMe': authController.aboutMeProfileController.text,
                        'phone': authController.phoneProfileController.text,
                        'address': authController.addressProfileController.text,
                      });

                      authController.fromFieldsToMainUser();
                      if (authController.imageFile != null) {
                        var storageRef = FirebaseStorage.instance.ref().child(
                            'path/to/storage/${authController.imageFile!.path.split('/').last}');
                        print("-------------------------");
                        await storageRef.putFile(authController.imageFile!);
                      }

                      // Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
