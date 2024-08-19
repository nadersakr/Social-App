// ignore_for_file: avoid_print

import 'dart:io';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/view_model/post_viewmodel.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  AddPostScreenState createState() => AddPostScreenState();
}

class AddPostScreenState extends State<AddPostScreen> {
  File? _image;
  PostViewmodel controller = PostViewmodel();

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
          // title: const Text('Add Post'),
          ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              'assets/svg/addPost.svg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                    width: 1.sw,
                    child:
                        TextClass.titleText("Upload Your Image", size: 20.sp)),
                SizedBox(
                  height: 30.h,
                ),
                _image != null
                    ? SizedBox(
                        width: 1.sw,
                        height: 200.h,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              // height: 200,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                            width: 1.0.sw,
                            height: 200.h,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: AppColors.darkBlue),
                            ),
                            child: Icon(
                              EneftyIcons.gallery_add_outline,
                              color: AppColors.darkBlue,
                              // weight: 45,
                              size: 40.h,
                            )),
                      ),
                SizedBox(height: 30.h),
                // button to change if the image is null it will be disabled else it will be enabled
                if (_image != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white),
                    onPressed: _pickImage,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: SizedBox(
                        width: 125.w,
                        child: const Row(
                          children: [
                            Text(
                              'change image   ',
                              style: TextStyle(color: AppColors.darkBlue),
                            ),
                            Icon(
                              EneftyIcons.gallery_add_outline,
                              color: AppColors.darkBlue,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  const SizedBox(),
                const Spacer(),
                GestureDetector(
                    onTap: () async {
                      await controller.addPost(
                          _image, context, authController, hour, now, amPm);
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset('assets/svg/addIcon.svg',
                        height: 100.w, width: 100.w, fit: BoxFit.cover)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
