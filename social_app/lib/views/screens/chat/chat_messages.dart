import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:social_app/model/message.dart';
import 'package:social_app/utils/colors.dart';

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
                        color: AppColors.lightGray,
                        borderRadius: messages[index].isMe!
                            ? BorderRadius.only(
                                topLeft: Radius.circular(20.0.r),
                                bottomLeft: Radius.circular(20.0.r),
                                bottomRight: Radius.circular(20.0.r),
                              )
                            : BorderRadius.only(
                                topRight: Radius.circular(20.0.r),
                                bottomLeft: Radius.circular(20.0.r),
                                bottomRight: Radius.circular(20.0.r),
                              )),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 14.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Column(
                        crossAxisAlignment: messages[index].isMe!
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            messages[index].message!,
                            style: const TextStyle(
                              color: AppColors.midGrey,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            DateFormat.jm()
                                .format(DateTime.parse(messages[index].time!)),
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
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
