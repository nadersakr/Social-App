import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Home/home_main_contents.dart';
import 'package:social_app/views/screens/auth/widgets/home_drawer.dart';
import 'package:social_app/provider/auth/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("homeeeeeeeee rebuild");
    AuthController authControllerListenFalse =
        Provider.of<AuthController>(context, listen: false);
    return SafeArea(
      child: Scaffold(
       
        body: SafeArea(
          child: FutureBuilder(
            future: authControllerListenFalse.getAppData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error Occured"));
              } else {
                return homeMainContent(context);
              }
            },
          ),
        ),
        drawer: HomeDrawer(authController: authControllerListenFalse),
      ),
    );
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
