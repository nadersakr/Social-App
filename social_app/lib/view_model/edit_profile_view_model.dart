import 'dart:io';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/services/Firebase/Firebase%20FireStore/firebase_firestore_small_servies.dart';
import 'package:social_app/utils/dinmentions.dart';
import 'package:social_app/view_model/user_viewmodel.dart';
import 'package:social_app/views/screens/edit_profile_screen/pic_widget.dart';

class EditProfileViewModel
    with EditProfileStrings, EditProfileAssets, dimentions, EditProfileIcons {
  String personsvg = 'assets/svg/person.svg';
  String? userAvatar = UserViewModel.userModel!.avatar;
  static XFile? selectedImage;
  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController lastNameController = TextEditingController();
  static TextEditingController usernameController = TextEditingController();
  static final GlobalKey<FormState> formKeyEditProfile = GlobalKey<FormState>();
  void changeUserAvatar(PicWidget picWidget, File imageFile) {
    picWidget.changeTofile(imageFile);
  }

  Future<void> uploadImage(PicWidget picWidget, BuildContext context) async {
    {
      final picker = ImagePicker();
      selectedImage = await picker.pickImage(source: ImageSource.gallery);
      if (selectedImage != null) {
        changeUserAvatar(picWidget, File(selectedImage!.path));
      }
    }
  }

  Future<bool> uploadSelectedImage() async {
    if (selectedImage == null) {
      return false;
    }
    return await FireFirestoreSmallServices()
        .uploadAndsaveImageUrlTOUserData(File(selectedImage!.path));
  }

  Future<bool> uploadUserInfo(BuildContext context) async {
    return await FireFirestoreSmallServices().saveUserInfo(
        firstNameController.text,
        lastNameController.text,
        usernameController.text);
  }
}

mixin EditProfileStrings {
  String get firstNameString => "First Name";
  String get lastNameString => "Last Name";
  String get userNameString => "Username";
  String get saveString => "Save Changes";
  String get selectImageString => "Select Image";
}
mixin EditProfileIcons {
  IconData get userSearchOutlineIcon => EneftyIcons.user_search_outline;
  IconData get userOutlineIcon => EneftyIcons.user_outline;
}
mixin EditProfileAssets {
  String get mainSVG => "assets/svg/mainShap.svg";
}
mixin dimentions {
  double get wholeWidth => Dimention.wholeHeight;
  double get editProfileImageHeight => 0.4.sh;
  double get heightFromTop => 0.05.sh;
  double get paddingHeight => 0.01.sh;
  double get paddingHeightTwo => 0.02.sh;
  double get verySmallHeight => 0.008.sh;
  double get heightSpace_50 => Dimention.heightSpace_50;
  double get squareHeightAndWidth90 => 90.w;
  double get squareHeightAndWidth75 => 75.h;
  double get squareHeightAndWidth100 => 100.w;
  double get fontSize28 => 28.sp;
  double get fontSize15 => 15.sp;
}
