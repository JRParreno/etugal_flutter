part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class OnGetInitialChat extends ChatEvent {
  final ChatSessionEntity? chatSession;
  final String roomName;
  final int taskId;
  final int providerId;
  final int performerId;

  const OnGetInitialChat({
    required this.roomName,
    required this.providerId,
    required this.performerId,
    required this.taskId,
    this.chatSession,
  });

  @override
  List<Object?> get props => [
        roomName,
        chatSession,
        providerId,
        performerId,
        taskId,
      ];
}

class OnPaginateChat extends ChatEvent {}

class OnTryConnectToWebSocket extends ChatEvent {}

class OnGetConnectWebSocket extends ChatEvent {
  final bool isConnected;

  const OnGetConnectWebSocket({
    required this.isConnected,
  });

  @override
  List<Object> get props => [isConnected];
}

class OnSendChat extends ChatEvent {
  final String message;

  const OnSendChat({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

class OnReceivedMessageChat extends ChatEvent {
  final dynamic message;

  const OnReceivedMessageChat({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
