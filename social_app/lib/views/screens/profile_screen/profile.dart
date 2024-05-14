import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/view_model/user_viewmodel.dart';
import 'package:social_app/views/reusable_components_widgets/plugins/masonry_grid_view.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';
import 'package:social_app/views/screens/profile_screen/custom_clip_path.dart';

import '../../../view_model/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = ProfileViewModel();
    print(UserViewModel.userModel!.avatar);
    print(profileViewModel.userAvatar);
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: profileViewModel.wholeWidth,
              height: profileViewModel.profileImageHeight,
              child: SvgPicture.asset(
                profileViewModel.profileImage,
                fit: BoxFit.fill,
              )),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: profileViewModel.heightFromTop),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: profileViewModel.squareHeightAndWidth75,
                      height: profileViewModel.squareHeightAndWidth75,
                      child: ClipPath(
                        clipper: CustomClipPath(),
                        child: profileViewModel.userAvatar == null
                            ? SvgPicture.asset(
                                profileViewModel.personsvg,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                profileViewModel.userAvatar!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: profileViewModel.squareHeightAndWidth100,
                      height: profileViewModel.squareHeightAndWidth100,
                      child: SvgPicture.asset(
                        profileViewModel.mainSVG,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: profileViewModel.paddingHeight,
                  bottom: profileViewModel.paddingHeightTwo,
                ),
                child: TextClass.titleText(profileViewModel.fullNameString,
                    size: 21.sp),
              ),
              TextClass(
                  text: "@${profileViewModel.usernameString}", size: 15.sp),
              SizedBox(
                height: profileViewModel.heightSpace_50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextClass.subBodyText(
                    profileViewModel.postsString,
                    color: AppColors.midGrey,
                  ),
                  TextClass.subBodyText(
                    profileViewModel.followersString,
                    color: AppColors.midGrey,
                  ),
                  TextClass.subBodyText(
                    profileViewModel.followsString,
                    color: AppColors.midGrey,
                  ),
                ],
              ),
              SizedBox(
                height: profileViewModel.verySmallHeight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextClass.subTitleText(profileViewModel.numberOfPostsString),
                  TextClass.subTitleText(
                      profileViewModel.numberOfFollowersString),
                  TextClass.subTitleText(
                      profileViewModel.numberOfFollowsString),
                ],
              ),
              SizedBox(
                height: profileViewModel.paddingHeight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      EneftyIcons.gallery_outline,
                      color: AppColors.darkBlue,
                      size: profileViewModel.fontSize28,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      EneftyIcons.save_2_outline,
                      size: profileViewModel.fontSize28,
                      color: AppColors.midBlack,
                    ),
                    onPressed: () {},
                  )
                ],
              ),

              // TODO Add Dimentions to [profileviewmodel]
              Padding(
                padding: EdgeInsets.all(12.w),
                child: SizedBox(
                  height: 0.4.sh,
                  child: MasonryGridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.w,
                    crossAxisSpacing: 12.w,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(20.sp),
                          child: Image.network(
                            authController.mainUser.posts![index]['imageUrl'] ??
                                "https://img.freepik.com/free-vector/flat-arabic-pattern-background_79603-1826.jpg?size=626&ext=jpg&ga=GA1.1.1039938112.1708868328&semt=sph",
                            fit: BoxFit.cover,
                          ));
                    },
                    itemCount: (authController.mainUser.posts ?? []).length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
