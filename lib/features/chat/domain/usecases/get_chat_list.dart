import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:etugal_flutter/features/chat/domain/repository/chat_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetChatList implements UseCase<ChatListEntity, String?> {
  final ChatRepository repository;

  const GetChatList(this.repository);

  @override
  Future<Either<Failure, ChatListEntity>> call(String? params) async {
    return await repository.getChatList(params);
  }
}
