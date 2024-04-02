import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/views/screens/chat/chat_screen.dart';

class ChatKit extends StatelessWidget {
  final String lastMessage;
  final String time;
  final MainUser friend;
  const ChatKit(
      {super.key,
      required this.friend,
      required this.lastMessage,
      required this.time});

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('jm').format(DateTime.parse(time));
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(resevier: friend),
              ),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(friend.avatar),
            ),
            title: Text(
              friend.userName ?? 'User Name',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Row(
              children: <Widget>[
                Text(
                  lastMessage,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  ' - ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  formattedTime, // You need to provide this variable
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.chat,
              color: Colors.blue,
            ),
          ),
        ),
        const Divider(
          height: 10,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
