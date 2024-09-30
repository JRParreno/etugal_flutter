import 'dart:convert';
import 'package:etugal_flutter/features/chat/data/models/index.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';

class ChatMessagesModel extends ChatMessagesEntity {
  const ChatMessagesModel({
    super.nextPage,
    required super.totalCount,
    required super.chats,
  });

  factory ChatMessagesModel.fromJson(Map<String, dynamic> map) {
    return ChatMessagesModel(
      nextPage: map['next_page'],
      totalCount: map['count']?.toInt() ?? 0,
      chats:
          List<ChatModel>.from(map['results'].map((x) => ChatModel.fromMap(x))),
    );
  }
}
