import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:etugal_flutter/features/chat/domain/repository/chat_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetChatSession implements UseCase<ChatSessionEntity, String> {
  final ChatRepository repository;

  const GetChatSession(this.repository);

  @override
  Future<Either<Failure, ChatSessionEntity>> call(String params) async {
    return await repository.getChatSession(params);
  }
}
