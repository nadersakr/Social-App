import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/reusable_components_widgets/plugins/masonry_grid_view.dart';
// import 'package:social_app/views/screens/Friends/my_friends.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';
import 'package:social_app/views/screens/profile_screen/custom_clip_path.dart';
// import 'package:social_app/views/screens/profile_screen/edit_profile.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     AuthController authController =
//         Provider.of<AuthController>(context, listen: false);
//     return Scaffold(
//       // appBar:
//       //  AppBar(title: const Text('My Profile'), actions: [
//       //   IconButton(
//       //       onPressed: () {
//       //         Navigator.push(context,
//       //             MaterialPageRoute(builder: (context) =>  const MyFriends()));
//       //       },
//       //       icon: const Icon(
//       //         Icons.people,
//       //         size: 28,
//       //       )),
//       //   const SizedBox(
//       //     width: 15,
//       //   )
//       // ]),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 80,
//                 backgroundImage: NetworkImage(
//                   authController.mainUser.avatar!,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: Text(
//                 authController.mainUser.userName ?? "User Name",
//                 style: const TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Center(
//               child: Text(
//                 '${authController.mainUser.bio}',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildSectionTitle('About Me'),
//             const SizedBox(height: 10),
//             Text(
//               '${authController.mainUser.aboutMe}',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[800],
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildSectionTitle('Contact Information'),
//             const SizedBox(height: 10),
//             _buildContactInfoTile(Icons.email, 'Email',
//                 authController.mainUser.email ?? "user@example.com"),
//             _buildContactInfoTile(
//                 Icons.phone, 'Phone', '${authController.mainUser.phone}'),
//             _buildContactInfoTile(Icons.location_on, 'Address',
//                 '${authController.mainUser.address}'),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: FloatingActionButton(
//           onPressed: () {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const EditProfileScreen()));
//           },
//           child: const Icon(Icons.edit),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget _buildContactInfoTile(IconData icon, String title, String subtitle) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       subtitle: Text(subtitle),
//     );
//   }
// }

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: 1.sw,
              height: 0.4.sh,
              child: SvgPicture.asset(
                "assets/svg/profile.svg",
                fit: BoxFit.fill,
              )),
          SizedBox(
            width: 1.sw,
            child: Column(
              children: [
                SizedBox(
                  height: 0.05.sh,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    ClipPath(
                      clipper: CustomClipPath(),
                      child: SizedBox(
                        width: 90.w,
                        height: 90.w,
                        child: Image.network(
                          authController.mainUser.avatar!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 100.w,
                      child: SvgPicture.asset(
                        "assets/svg/mainShap.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                TextClass.titleText("Nader Sakr", size: 21.sp),
                SizedBox(
                  height: 0.01.sh,
                ),
                TextClass(
                    text: "@${authController.mainUser.userName}", size: 15.sp),
                SizedBox(
                  height: 0.05.sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextClass.subBodyText(
                      "Posts",
                      color: AppColors.midGrey,
                    ),
                    TextClass.subBodyText(
                      "Followers",
                      color: AppColors.midGrey,
                    ),
                    TextClass.subBodyText(
                      "Follows",
                      color: AppColors.midGrey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.008.sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextClass.subTitleText("35"),
                    TextClass.subTitleText("1,506"),
                    TextClass.subTitleText("128"),
                  ],
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        EneftyIcons.gallery_outline,
                        color: AppColors.darkBlue,
                        size: 28.sp,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        EneftyIcons.save_2_outline,
                        size: 28.sp,
                        color: AppColors.midBlack,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
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
                              authController.mainUser.posts![index]['imageUrl'],
                              fit: BoxFit.cover,
                            ));
                      },
                      itemCount: authController.mainUser.posts!.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
