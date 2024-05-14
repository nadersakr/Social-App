import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/services/Firebase/Firebase%20FireStore/firebase_firestore_small_servies.dart';
import 'package:social_app/views/screens/edit_profile_screen/pic_widget.dart';
import 'package:social_app/views/screens/profile_screen/custom_clip_path.dart';

import '../../../view_model/edit_profile_view_model.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});
  @override
  Widget build(BuildContext context) {
    EditProfileViewModel editProfileViewModel = EditProfileViewModel();
    PicWidget picWidget = Provider.of<PicWidget>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: editProfileViewModel.wholeWidth,
          ),
          Padding(
            padding: EdgeInsets.only(top: editProfileViewModel.heightFromTop),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: editProfileViewModel.squareHeightAndWidth75,
                  height: editProfileViewModel.squareHeightAndWidth75,
                  child: ClipPath(
                    clipper: CustomClipPath(),
                    child: Consumer<PicWidget>(
                      builder:
                          (BuildContext context, picWidget, Widget? child) {
                        print("rebuilt");
                        return picWidget.mainWidget();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: editProfileViewModel.squareHeightAndWidth100,
                  height: editProfileViewModel.squareHeightAndWidth100,
                  child: SvgPicture.asset(
                    editProfileViewModel.mainSVG,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: editProfileViewModel.paddingHeightTwo),
            padding: EdgeInsets.all(editProfileViewModel.paddingHeight),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: GestureDetector(
              onTap: () async {
                {
                  final picker = ImagePicker();
                  final pickedImage =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    editProfileViewModel.changeUserAvatar(
                        picWidget, File(pickedImage.path));

                    bool key = await FireFirestoreSmallServices()
                        .uploadAndsaveImageUrlTOUserData(
                            File(pickedImage.path));

                    print(key);
                  }
                }
              },
              child: const Text(
                'Upload Photo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget picWidget(EditProfileViewModel editProfileViewModel) {
    return editProfileViewModel.userAvatar == null
        ? SvgPicture.asset(
            editProfileViewModel.personsvg,
            fit: BoxFit.fill,
          )
        : Image.network(
            editProfileViewModel.userAvatar!,
            fit: BoxFit.cover,
          );
  }
}
