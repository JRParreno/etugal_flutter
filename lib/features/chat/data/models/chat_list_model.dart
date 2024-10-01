import 'package:etugal_flutter/features/chat/data/models/index.dart';
import 'package:etugal_flutter/features/chat/domain/entities/chat_list_entity.dart';

class ChatListModel extends ChatListEntity {
  const ChatListModel({
    super.nextPage,
    required super.totalCount,
    required super.chatSession,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      chatSession: List<ChatSessionModel>.from(
          json["results"]!.map((x) => ChatSessionModel.fromJson(x))),
      totalCount: json["count"],
      nextPage: json["next"],
    );
  }
}
