import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class ChatSessionEntity {
  final int id;
  final String roomName;
  final TaskUserProfileEntity provider;
  final TaskUserProfileEntity performer;
  final TaskEntity task;

  const ChatSessionEntity({
    required this.id,
    required this.roomName,
    required this.provider,
    required this.performer,
    required this.task,
  });

  ChatSessionEntity copyWith({
    int? id,
    String? roomName,
    TaskUserProfileEntity? provider,
    TaskUserProfileEntity? performer,
    TaskEntity? task,
  }) {
    return ChatSessionEntity(
      id: id ?? this.id,
      roomName: roomName ?? this.roomName,
      provider: provider ?? this.provider,
      performer: performer ?? this.performer,
      task: task ?? this.task,
    );
  }
}
