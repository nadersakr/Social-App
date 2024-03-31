import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/model/message.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/provider/chat_provider.dart';
import 'package:social_app/views/screens/chat/chat_input.dart';
import 'package:social_app/views/screens/chat/chat_messages.dart';

class ChatScreen extends StatelessWidget {
  final MainUser resevier;

  const ChatScreen({super.key, required this.resevier});

  @override
  Widget build(BuildContext context) {
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    ChatServises chatServises =
        Provider.of<ChatServises>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(resevier.avatar!),
            ),
            const SizedBox(
              width: 15,
            ),
            Text('${resevier.userName}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Selector<ChatServises, List<Message>>(
        selector: (context, chatServises) => chatServises.messages,
        builder: (context, value, child) => SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream:
                    chatServises.getMessagesStream(authController, resevier),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
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
                    chatServises.messages.sort((b, a) => DateTime.parse(a.time!)
                        .compareTo(DateTime.parse(b.time!)));

                    

                    // display messages
                    return Selector<ChatServises, List<Message>>(
                      selector: (context, chatServises) =>
                          chatServises.messages,
                      builder: (context, messages, _) =>
                          ChatMessages(messages: chatServises.messages),
                    );
                  } else {
                    return const Center(
                      child: Text('No messages yet'),
                    );
                  }
                },
              ),
              ChatInput(
                //making two references to the same chat on each user's chat collection it needs to be handled if we would use group chat

                onSend: (text) async {
                  chatServises.sendmessage(text, authController, resevier);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
