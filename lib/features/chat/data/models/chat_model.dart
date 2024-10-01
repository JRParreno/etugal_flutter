import 'package:etugal_flutter/features/chat/domain/entities/index.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.message,
    required super.timeStamp,
    required super.username,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    final String username = map.containsKey('username')
        ? map["username"]
        : map['user_profile']['user']['username'];
    final String timestamp =
        map.containsKey('timestamp') ? map["timestamp"] : map['time_stamp'];

    return ChatModel(
      message: map['message'] ?? '',
      timeStamp: timestamp,
      username: username,
    );
  }
}
