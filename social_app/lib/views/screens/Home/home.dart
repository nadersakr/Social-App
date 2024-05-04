import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/view_model/home_viewmodel.dart';
import 'package:social_app/view_model/user_viewmodel.dart';
import 'package:social_app/views/screens/Home/add_post.dart';
import 'package:social_app/views/screens/Home/home_main_contents.dart';
import 'package:social_app/views/screens/auth/widgets/home_drawer.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/views/screens/chat/chats.dart';
import 'package:social_app/views/screens/favouirte_posts_screen/favourate_posts.dart';
import 'package:social_app/views/screens/profile_screen/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AuthController authControllerListenFalse =
        Provider.of<AuthController>(context, listen: false);
    List<Widget> screens = [
      const HomePageWidjet(),
      const ChatsScreen(),
      const FavoriteScreen(),
      const ProfileScreen(),
    ];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Selector<MenuCotroller, int>(
                builder: (context, value, child) {
                  return screens[value];
                },
                selector: (context, value) => value.currentIndex),
            const HomePageMenu(),
          ],
        ),
        drawer: HomeDrawer(authController: authControllerListenFalse),
      ),
    );
  }
}

class HomePageWidjet extends StatelessWidget {
  const HomePageWidjet({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel();
    // AuthController authControllerListenFalse =
    //     Provider.of<AuthController>(context, listen: false);
    return SizedBox(
      height: 1.sh - 50.h,
      child: FutureBuilder(
        future: homeScreenViewModel.loadAppData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else {
            return homeMainContent(context);
          }
        },
      ),
    );
  }
}

class HomePageMenu extends StatelessWidget {
  const HomePageMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 80.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50.h,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Selector<MenuCotroller, int>(
                  selector: (context, value) => value.currentIndex,
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(EneftyIcons.home_2_outline),
                          color: value == 0
                              ? AppColors.darkBlue
                              : AppColors.darkBlack,
                          onPressed: () {
                            Provider.of<MenuCotroller>(context, listen: false)
                                .changeIndex(0);
                          },
                        ),
                        IconButton(
                          icon: const Icon(EneftyIcons.message_2_outline),
                          color: value == 1
                              ? AppColors.darkBlue
                              : AppColors.darkBlack,
                          onPressed: () {
                            Provider.of<MenuCotroller>(context, listen: false)
                                .changeIndex(1);
                          },
                        ),
                        SizedBox(
                          width: 70.w,
                        ),
                        IconButton(
                          icon: const Icon(EneftyIcons.heart_outline),
                          color: value == 2
                              ? AppColors.darkBlue
                              : AppColors.darkBlack,
                          onPressed: () {
                            Provider.of<MenuCotroller>(context, listen: false)
                                .changeIndex(2);
                          },
                        ),
                        IconButton(
                          icon: const Icon(EneftyIcons.user_outline),
                          color: value == 3
                              ? AppColors.darkBlue
                              : AppColors.darkBlack,
                          onPressed: () {
                            Provider.of<MenuCotroller>(context, listen: false)
                                .changeIndex(3);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddPostScreen();
                  }));
                },
                child: SvgPicture.asset('assets/svg/addIcon.svg',
                    height: 100.w, width: 100.w, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCotroller extends ChangeNotifier {
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
// class HomeNavigationBar extends StatelessWidget {
//   const HomeNavigationBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//       fixedColor: Colors.white,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(
//             EneftyIcons.home_outline,
//             color: AppColors.darkBlack,
//           ),
//           label: 'h',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             EneftyIcons.message_2_outline,
//             color: AppColors.darkBlack,
//           ),
//           label: 'm',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             EneftyIcons.add_circle_outline,
//             color: AppColors.darkBlack,
//           ),
//           label: 'a',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             EneftyIcons.heart_outline,
//             color: AppColors.darkBlack,
//           ),
//           label: 'n',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             EneftyIcons.user_outline,
//             color: AppColors.darkBlack,
//           ),
//           label: 'p',
//         ),
//       ],
//     );
//   }
// }
