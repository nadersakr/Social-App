import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/utils/widgets/custom_button.dart';
import 'package:social_app/view_model/user_viewmodel.dart';
import 'package:social_app/views/reusable_components_widgets/validators.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';
import 'package:social_app/views/screens/auth/widgets/custom_text_field.dart';
import 'package:social_app/views/screens/edit_profile_screen/pic_widget.dart';
import 'package:social_app/views/screens/profile_screen/custom_clip_path.dart';
import '../../../view_model/edit_profile_view_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    EditProfileViewModel.firstNameController = TextEditingController();
    EditProfileViewModel.lastNameController = TextEditingController();
    EditProfileViewModel.usernameController = TextEditingController();

    EditProfileViewModel.firstNameController.text =
        UserViewModel.userModel!.firstName ?? "";
    EditProfileViewModel.lastNameController.text =
        UserViewModel.userModel!.lastName ?? "";
    EditProfileViewModel.usernameController.text =
        UserViewModel.userModel!.userName ?? "";

    super.initState();
  }

  @override
  void dispose() {
    EditProfileViewModel.firstNameController.dispose();
    EditProfileViewModel.lastNameController.dispose();
    EditProfileViewModel.usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel editProfileViewModel = EditProfileViewModel();
    PicWidget picWidget = Provider.of<PicWidget>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(editProfileViewModel.paddingHeightTwo),
        child: SingleChildScrollView(
          child: Form(
            key: EditProfileViewModel.formKeyEditProfile,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: editProfileViewModel.wholeWidth,
                ),
                Stack(
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
                      await editProfileViewModel.uploadImage(
                          picWidget, context);
                    },
                    child: Text(
                      editProfileViewModel.selectImageString,
                      style: TextStyle(
                        fontSize: editProfileViewModel.fontSize15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(editProfileViewModel.paddingHeight),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextClass.subBodyText(
                          editProfileViewModel.firstNameString)),
                ),
                CustomTextField(
                    suffixIcon: Icon(editProfileViewModel.userOutlineIcon),
                    controller: EditProfileViewModel.firstNameController,
                    hintText: editProfileViewModel.firstNameString,
                    maxlenght: 9,
                    keyboardType: TextInputType.text,
                    validator: Tvalidator.firstNameValidator),
                Padding(
                  padding: EdgeInsets.all(editProfileViewModel.paddingHeight),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextClass.subBodyText(
                          editProfileViewModel.lastNameString)),
                ),
                CustomTextField(
                    suffixIcon: Icon(editProfileViewModel.userOutlineIcon),
                    controller: EditProfileViewModel.lastNameController,
                    hintText: editProfileViewModel.lastNameString,
                    maxlenght: 9,
                    keyboardType: TextInputType.text,
                    validator: Tvalidator.lastNameValidator),
                Padding(
                  padding: EdgeInsets.all(editProfileViewModel.paddingHeight),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextClass.subBodyText(
                          editProfileViewModel.userNameString)),
                ),
                CustomTextField(
                  suffixIcon: Icon(editProfileViewModel.userSearchOutlineIcon),
                  controller: EditProfileViewModel.usernameController,
                  hintText: editProfileViewModel.userNameString,
                  maxlenght: 9,
                  keyboardType: TextInputType.text,
                  validator: Tvalidator.usernameValidator,
                ),
                SizedBox(
                  height: editProfileViewModel.paddingHeight,
                ),
                CustomButton(
                  buttonText: editProfileViewModel.saveString,
                  onPressed: () {
                    if (EditProfileViewModel.formKeyEditProfile.currentState!
                        .validate()) {
                      
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
