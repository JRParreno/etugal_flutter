import 'package:etugal_flutter/features/chat/domain/entities/chat_session_entity.dart';

class ChatListEntity {
  final String? nextPage;
  final int totalCount;
  final List<ChatSessionEntity> chatSession;

  const ChatListEntity({
    this.nextPage,
    required this.totalCount,
    required this.chatSession,
  });

  ChatListEntity copyWith({
    String? nextPage,
    int? totalCount,
    List<ChatSessionEntity>? chatSession,
  }) {
    return ChatListEntity(
      nextPage: nextPage ?? this.nextPage,
      totalCount: totalCount ?? this.totalCount,
      chatSession: chatSession ?? this.chatSession,
    );
  }

  factory ChatListEntity.empty() =>
      const ChatListEntity(chatSession: [], totalCount: -1);
}
