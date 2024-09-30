import 'package:etugal_flutter/features/chat/domain/entities/chat_list_entity.dart';

class ChatListModel extends ChatListEntity {
  const ChatListModel({
    super.nextPage,
    required super.totalCount,
    required super.chatSession,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      chatSession: json["chat_session"],
      totalCount: json["total_count"],
      nextPage: json["next"],
    );
  }
}
