import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:etugal_flutter/features/chat/domain/repository/chat_repository.dart';

import 'package:fpdart/fpdart.dart';

class CreateChatSession
    implements UseCase<ChatSessionEntity, CreateChatSessionParams> {
  final ChatRepository repository;

  const CreateChatSession(this.repository);

  @override
  Future<Either<Failure, ChatSessionEntity>> call(
      CreateChatSessionParams params) async {
    return await repository.createChatSession(
      performerId: params.performerId,
      providerId: params.providerId,
      roomName: params.roomName,
      taskId: params.taskId,
    );
  }
}

class CreateChatSessionParams {
  final String roomName;
  final int providerId;
  final int performerId;
  final int taskId;

  CreateChatSessionParams({
    required this.roomName,
    required this.providerId,
    required this.performerId,
    required this.taskId,
  });
}
