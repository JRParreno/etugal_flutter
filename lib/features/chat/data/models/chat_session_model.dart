import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/data/models/index.dart';

class ChatSessionModel extends ChatSessionEntity {
  const ChatSessionModel({
    required super.id,
    required super.roomName,
    required super.provider,
    required super.performer,
    required super.task,
  });

  factory ChatSessionModel.fromJson(Map<String, dynamic> map) {
    return ChatSessionModel(
      id: map['id'] as int,
      roomName: map['room_name'] as String,
      provider: TaskUserProfileModel.fromJson(
          map['provider'] as Map<String, dynamic>),
      performer: TaskUserProfileModel.fromJson(
          map['performer'] as Map<String, dynamic>),
      task: TaskModel.fromJson(map['task'] as Map<String, dynamic>),
    );
  }
}
