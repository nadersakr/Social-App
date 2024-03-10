import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app/model/message.dart';

class ChatMessages extends StatelessWidget {
  final List<Message> messages;
  const ChatMessages({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: messages[index].isMe!
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: messages[index].isMe!
                          ? Colors.blue
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: messages[index].isMe!
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          messages[index].message!,
                          style: TextStyle(
                            color: messages[index].isMe!
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          DateFormat.jm()
                              .format(DateTime.parse(messages[index].time!)),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: messages[index].isMe!
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
