class Message {
  String? message;
  String? receiverName;
  String? time;
  bool? isMe;

  Message({this.message, this.receiverName, this.time, this.isMe});

  static Message fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      receiverName: json['reseverName'],
      time: json['time'],
      isMe: json['isMe'],
    );
  }
}
