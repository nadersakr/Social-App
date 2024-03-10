import 'package:social_app/model/user_model.dart';

class Chat {
  String? lastMessage;
  String time;
  MainUser? friend;

  Chat({required this.lastMessage, required this.time});
  static Chat fromJson(Map<String, dynamic> json) {
    return Chat(
      lastMessage: json['lastMessage'],
      time: json['time'],
    );
  }
}
