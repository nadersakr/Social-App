import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/utils/dinmentions.dart';
import 'package:social_app/view_model/user_viewmodel.dart';

class ProfileViewModel with profileStrings, profileAssets, dimentions {}

mixin profileStrings {
  String usernameString = UserViewModel.userModel!.userName ?? "Full Name";
  String postsString = 'Posts';
  String fullNameString =
      "${UserViewModel.userModel!.firstName} ${UserViewModel.userModel!.lastName}";
  String followersString = 'Followers';
  String followsString = 'Follows';
  String numberOfPostsString = '35';
  String numberOfFollowersString = '1.506';
  String numberOfFollowsString = '128';
}

mixin profileAssets {
  String get profileImage => 'assets/svg/profile.svg';
  String get mainSVG => "assets/svg/mainShap.svg";
}
mixin dimentions {
  double get wholeWidth => Dimention.wholeHeight;
  double get profileImageHeight => 0.4.sh;
  double get heightFromTop => 0.05.sh;
  double get paddingHeight => 0.01.sh;
  double get paddingHeightTwo => 0.02.sh;
  double get verySmallHeight =>0.008.sh;
  double get heightSpace_50 => Dimention.heightSpace_50;
  double get squareHeightAndWidth90 => 90.w;
  double get squareHeightAndWidth100 => 100.w;


  double get fontSize28 => 28.sp;
}
