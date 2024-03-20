import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/provider/chat_provider.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/utils/shared-preferences/shared_preferences.dart';
import 'package:social_app/views/screens/Home/add_post.dart';
import 'package:social_app/views/screens/Home/home.dart';
import 'package:social_app/views/screens/add_post_screen/test_screen.dart';
import 'package:social_app/views/screens/auth/login/login_screen.dart';
import 'package:social_app/views/screens/on_boarding_screen/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.initSharedPreferences();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool isShowBoarding =
      AppSharedPreferences.getValue(value: 'isShowenOnboarding') ?? false;
  bool islogin = AppSharedPreferences.getValue(value: 'islogin') ?? false;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthController()),
      ChangeNotifierProvider(create: (_) => PostController()),
      ChangeNotifierProvider(create: (_) => ChatServises()),
    ],
    child: MyApp(isShowBording: isShowBoarding, islogin: islogin),
  ));
}

class MyApp extends StatelessWidget {
  final bool isShowBording;
  final bool islogin;
  const MyApp({super.key, required this.isShowBording, required this.islogin});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isShowBording
            ? islogin
                ? const HomeScreen()
                : const LoginScreen()
            : const OnBoardignScreen(),
      ),
    );
  }
}
