import 'package:etugal_flutter/features/chat/domain/entities/index.dart';

class ChatMessagesEntity {
  final String? nextPage;
  final int totalCount;
  final List<ChatEntity> chats;

  const ChatMessagesEntity({
    this.nextPage,
    required this.totalCount,
    required this.chats,
  });

  ChatMessagesEntity copyWith({
    String? nextPage,
    int? totalCount,
    List<ChatEntity>? chats,
  }) {
    return ChatMessagesEntity(
      nextPage: nextPage ?? this.nextPage,
      totalCount: totalCount ?? this.totalCount,
      chats: chats ?? this.chats,
    );
  }

  factory ChatMessagesEntity.empty() {
    return const ChatMessagesEntity(
      chats: [],
      totalCount: -1,
    );
  }
}
