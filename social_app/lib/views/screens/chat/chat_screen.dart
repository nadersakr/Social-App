import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/message.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/provider/chat_provider.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/views/screens/Home/reusable_widgets.dart';
import 'package:social_app/views/screens/chat/chat_input.dart';
import 'package:social_app/views/screens/chat/chat_messages.dart';
import 'package:social_app/views/screens/profile_screen/custom_clip_path.dart';

class ChatScreen extends StatelessWidget {
  final MainUser resevier;

  const ChatScreen({super.key, required this.resevier});

  @override
  Widget build(BuildContext context) {
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    ChatServises chatServises =
        Provider.of<ChatServises>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Container(
                  width: 1.sw,
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 32.w,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipPath(
                            clipper: CustomClipPath(),
                            child: SizedBox(
                              width: 90.w,
                              height: 90.w,
                              child: Image.network(
                                resevier.avatar,
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
                        width: 32.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextClass(
                            text:
                                "${(resevier.userName ?? 'User Name').substring(0, 1).toUpperCase()}${(resevier.userName ?? 'User Name').substring(1)}",
                            color: AppColors.darkBlack,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Selector<ChatServises, List<Message>>(
                selector: (context, chatServises) => chatServises.messages,
                builder: (context, value, child) => SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 380.h,
                        child: StreamBuilder(
                          stream: chatServises.getMessagesStream(
                              authController, resevier),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            }
                            if (snapshot.hasData) {
                              chatServises.messages.clear();
                              snapshot.data!.docs.forEach((element) {
                                Message message = Message(
                                    message: element['message'],
                                    time: element['time'],
                                    isMe: element['isMe']);
                                chatServises.messages.add(message);
                              });
                              chatServises.messages.sort((b, a) =>
                                  DateTime.parse(a.time!)
                                      .compareTo(DateTime.parse(b.time!)));

                              // display messages
                              return Selector<ChatServises, List<Message>>(
                                selector: (context, chatServises) =>
                                    chatServises.messages,
                                builder: (context, messages, _) => ChatMessages(
                                    messages: chatServises.messages),
                              );
                            } else {
                              return const Center(
                                child: Text('No messages yet'),
                              );
                            }
                          },
                        ),
                      ),
                      ChatInput(
                        //making two references to the same chat on each user's chat collection it needs to be handled if we would use group chat

                        onSend: (text) async {
                          chatServises.sendmessage(
                              text, authController, resevier);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
