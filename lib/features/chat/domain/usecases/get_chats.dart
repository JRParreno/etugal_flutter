import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:etugal_flutter/features/chat/domain/repository/chat_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetChats implements UseCase<ChatMessagesEntity, GetChatsParams> {
  final ChatRepository repository;

  const GetChats(this.repository);

  @override
  Future<Either<Failure, ChatMessagesEntity>> call(
      GetChatsParams params) async {
    return await repository.getChats(
      sessionId: params.sessionId,
      next: params.next,
    );
  }
}

class GetChatsParams {
  final String sessionId;
  final String? next;

  const GetChatsParams({
    required this.sessionId,
    this.next,
  });
}
