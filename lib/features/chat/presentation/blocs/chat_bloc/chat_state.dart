part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ViewStatus viewStatus;
  final ChatMessagesEntity chats;
  final ChatSessionEntity? chatSession;
  final bool isSending;
  final bool isWebSocketConnected;

  const ChatState({
    required this.chats,
    this.chatSession,
    this.isSending = false,
    this.isWebSocketConnected = false,
    this.viewStatus = ViewStatus.none,
  });

  ChatState copyWith({
    ViewStatus? viewStatus,
    ChatMessagesEntity? chats,
    bool? isSending,
    bool? isWebSocketConnected,
    ChatSessionEntity? chatSession,
  }) {
    return ChatState(
      viewStatus: viewStatus ?? this.viewStatus,
      chats: chats ?? this.chats,
      isSending: isSending ?? this.isSending,
      isWebSocketConnected: isWebSocketConnected ?? this.isWebSocketConnected,
      chatSession: chatSession ?? this.chatSession,
    );
  }

  @override
  List<Object?> get props => [
        viewStatus,
        chats,
        isSending,
        isWebSocketConnected,
        chatSession,
      ];
}

final class ChatInitial extends ChatState {
  ChatInitial() : super(chats: ChatMessagesEntity.empty());
}
