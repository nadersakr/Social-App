import 'package:intl/intl.dart';

String getDifferenceFromNow(String time) {
    // Parse the string to a DateTime object
    // Format: "06:53 AM, 12/03/2024"
    var format = DateFormat("hh:mm a, dd/MM/yyyy");
    DateTime dateTime;
    try {
      dateTime = format.parse(time);
    } catch (e) {
      return 'Invalid time format';
    }

    // Calculate the difference
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds.toInt() < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays ~/ 7}w ago';
    } else if (difference.inDays < 365) {
      return '${difference.inDays ~/ 30}m ago';
    } else {
      return '${difference.inDays ~/ 365}y ago';
    }
  }