// ignore_for_file: avoid_print

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:social_app/model/chat_model.dart';

import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/provider/chat_provider.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';
import 'package:social_app/views/screens/chat/chat_kit.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    ChatServises chatServises =
        Provider.of<ChatServises>(context, listen: true);
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: SvgPicture.asset(
            "assets/svg/backgroundChats.svg",
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
          ),
        ),
        SingleChildScrollView(
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 24.h, left: 24.w, bottom: 24.w),
                child: TextClass.titleText(
                  "Messages",
                  size: 24.sp,
                  color: AppColors.darkBlack,
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SizedBox(
                    height: 42.h,
                    width: 290.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset:
                                const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.white,
                          labelText: 'Search for content',
                          labelStyle: TextStyle(
                            color: AppColors.midLightGrey,
                            fontSize: 14.sp,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(14.r)),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: const Icon(
                              EneftyIcons.search_normal_2_outline,
                              color: AppColors.darkBlack,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          // Implement your search logic here
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 1.sh - 160.h,
                child: StreamBuilder(
                  stream: chatServises.getChatsStream(authController),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: TextClass.subTitleText('An Error Occurred'),
                      );
                    }
                    if (snapshot.hasData) {
                      return FutureBuilder(
                          future: setmainUsers(
                              chatServises, authController, snapshot),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child:
                                    TextClass.subBodyText('An Error Occurred.'),
                              );
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemBuilder: (context, i) => ChatKit(
                                  friend: snapshot.data![i].friend!,
                                  lastMessage:
                                      snapshot.data![i].lastMessage ?? "",
                                  time: snapshot.data![i].time,
                                ),
                                itemCount: snapshot.data!.length,
                              );
                            }
                            return const Center(
                              child: Text('No Chats'),
                            );
                          });
                    }
                    return const Center(
                      child: Text('No Chats'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

Future<List<Chat>> setmainUsers(ChatServises chatServises,
    AuthController authController, AsyncSnapshot<dynamic> snapshot) async {
  chatServises.chats.clear();
  for (var element in snapshot.data.docs) {
    Chat chat = Chat.fromJson(element.data());
    print('elemetn id ${element.id}');
    var friend = await authController.fromUIDToMainUser(element.id);
    print("friend ${friend.userName}");
    chat.friend = friend;
    chatServises.chats.add(chat);
  }
  print("before return chatServises.chatsMainUser.length");
  // print(chatServises.chats[0].time);
  print("before return chatServises.chatsMainUser.length");
  return chatServises.chats;
}
