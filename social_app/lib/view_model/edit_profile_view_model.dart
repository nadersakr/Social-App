import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/dinmentions.dart';
import 'package:social_app/view_model/user_viewmodel.dart';
import 'package:social_app/views/screens/edit_profile_screen/pic_widget.dart';

class EditProfileViewModel
    with EditProfileStrings, EditProfileAssets, dimentions {
  String personsvg = 'assets/svg/person.svg';
  String? userAvatar = UserViewModel.userModel!.avatar;

  void changeUserAvatar(PicWidget picWidget, File imageFile) {
    picWidget.changeTofile(imageFile);
  }
}

mixin EditProfileStrings {}

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
}
