import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Friends/friends_screen.dart';
import 'package:social_app/views/screens/Home/home_store_card.dart';
import 'package:social_app/views/screens/Home/home_tap_icon.dart';
import 'package:social_app/views/screens/Home/post.dart';
import 'package:social_app/views/screens/auth/widgets/home_drawer.dart';
import 'package:social_app/views/screens/chat/chat.dart';
import 'package:social_app/views/screens/profile_screen/profile.dart';
import 'package:social_app/provider/auth/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 

 
@override
void initState() {
  super.initState();

    AuthController authController = Provider.of<AuthController>(context,listen: false);
    authController.setUser();
    authController.getdata();
  
}

  @override
  Widget build(BuildContext context) {
    AuthController authController = Provider.of<AuthController>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Social App',
                        style: TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    StoryCard(),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TapButton(
                      widget: FriendsScreen(),
                      icon: Icon(Icons.people_outline_rounded),
                    ),
                    TapButton(
                      widget: ChatScreen(),
                      icon: Icon(Icons.chat_bubble_outline_rounded),
                    ),
                    TapButton(
                      widget: ProfileScreen(),
                      icon: Icon(Icons.person),
                    ),
                  ],
                ),
              ),
              const Divider(),
              PostCard(
                  avatarImage: 'https://via.placeholder.com/150',
                  userName: 'aaa',
                  postText: "${authController.user?.email}" ,
                  imageUrl: 'https://via.placeholder.com/300',
                  likesNumber: 24,
                  commentsNumber: 48,
                  sharessNumber: 3,
                  time: 'Posted 2 hours ago'),
              const Divider(),

              // Add more post cards here as needed
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your post functionality here
        },
        label: const Text('Create Post'),
        icon: const Icon(Icons.edit),
      ),
      drawer: HomeDrawer(authController: authController),
    );
  }
}
