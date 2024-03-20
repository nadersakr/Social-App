// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:social_app/model/chat_model.dart';

import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/provider/chat_provider.dart';
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
        appBar: AppBar(
          title: const Text('My Chats',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        body: StreamBuilder(
          stream: chatServises.getChatsStream(authController),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error occurred'),
              );
            }
            if (snapshot.hasData) {
              print("qqqqqqqqqqqqqqq");
              print(snapshot.data.docs.length);
              for (var element in snapshot.data.docs) {
                print('elemetn id ${element.data()}');
              }
              print("qqqqqqqqqqqqqqq");

              return FutureBuilder(
                  future: setmainUsers(chatServises, authController, snapshot),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error occurred'),
                      );
                    }
                    if (snapshot.hasData) {
                      print("kkkkkkkkkkkkkk ${snapshot.data!.length}");

                      return ListView.builder(
                        itemBuilder: (context, i) => ChatKit(
                          friend: snapshot.data![i].friend!,
                          lastMessage: snapshot.data![i].lastMessage ?? "",
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
