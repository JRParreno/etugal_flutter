import 'dart:developer';

import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isSender,
    required this.message,
    required this.timeStamp,
  });

  final bool isSender;
  final String message;
  final String timeStamp;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        margin: isSender
            ? const EdgeInsets.only(right: 10)
            : const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isSender ? Colors.white : ColorName.primary,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isSender ? Colors.black : Colors.white,
                ),
              ),
            ),
            Text(
              timeAgoStr(),
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }

  String timeAgoStr() {
    final DateTime currentDate = DateTime.now();
    final DateTime chatTimeStamp =
        DateTime.parse(timeStamp).toLocal(); // Convert to local time zone
    log(currentDate.toString(), name: 'CurrentDate');
    log(chatTimeStamp.toString(), name: 'chatTimeStamp');

    // Calculate the time difference
    final duration = currentDate.difference(chatTimeStamp);

    // Return the time ago string
    return timeago.format(currentDate.subtract(duration));
  }
}
