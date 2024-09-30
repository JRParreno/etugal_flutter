import 'dart:async';

import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:fpdart/fpdart.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatMessagesEntity>> getChats({
    required String sessionId,
    String? next,
  });
  Future<Either<Failure, ChatSessionEntity>> getChatSession(String roomName);
  Future<Either<Failure, ChatSessionEntity>> createChatSession({
    required String roomName,
    required int providerId,
    required int performerId,
    required int taskId,
  });
  Future<Either<Failure, ChatListEntity>> getChatList(String? nextPage);
}
