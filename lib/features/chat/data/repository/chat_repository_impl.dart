import 'dart:async';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/chat/data/datasource/chat_remote_data_source.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:etugal_flutter/features/chat/domain/repository/chat_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;

  const ChatRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ChatSessionEntity>> createChatSession({
    required String roomName,
    required int providerId,
    required int performerId,
    required int taskId,
  }) async {
    try {
      final response = await _remoteDataSource.createChatSession(
        performerId: performerId,
        providerId: providerId,
        roomName: roomName,
        taskId: taskId,
      );

      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, ChatListEntity>> getChatList(String? nextPage) async {
    try {
      final response = await _remoteDataSource.getChatList(nextPage);
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, ChatSessionEntity>> getChatSession(
      String roomName) async {
    try {
      final response = await _remoteDataSource.getChatSession(roomName);
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, ChatMessagesEntity>> getChats(
      {required String sessionId, String? next}) async {
    try {
      final response = await _remoteDataSource.getChats(
        sessionId: sessionId,
        next: next,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> createReportUser({
    required int reportedUserId,
    required String reason,
    List<XFile>? images,
    String? additionalInfo,
  }) async {
    try {
      final response = await _remoteDataSource.createReportUser(
        reportedUserId: reportedUserId,
        reason: reason,
        additionalInfo: additionalInfo,
        images: images,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }
}
