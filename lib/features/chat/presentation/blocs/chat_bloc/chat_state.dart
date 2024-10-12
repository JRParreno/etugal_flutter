part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ViewStatus viewStatus;
  final ChatMessagesEntity chats;
  final ChatSessionEntity? chatSession;
  final bool isSending;
  final bool isWebSocketConnected;
  final String? errorMessage;
  const ChatState({
    required this.chats,
    this.chatSession,
    this.isSending = false,
    this.isWebSocketConnected = false,
    this.viewStatus = ViewStatus.none,
    this.errorMessage,
  });

  ChatState copyWith({
    ViewStatus? viewStatus,
    ChatMessagesEntity? chats,
    bool? isSending,
    bool? isWebSocketConnected,
    ChatSessionEntity? chatSession,
    String? errorMessage,
  }) {
    return ChatState(
      viewStatus: viewStatus ?? this.viewStatus,
      chats: chats ?? this.chats,
      isSending: isSending ?? this.isSending,
      isWebSocketConnected: isWebSocketConnected ?? this.isWebSocketConnected,
      chatSession: chatSession ?? this.chatSession,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        viewStatus,
        chats,
        isSending,
        isWebSocketConnected,
        chatSession,
        errorMessage,
      ];
}

final class ChatInitial extends ChatState {
  ChatInitial() : super(chats: ChatMessagesEntity.empty());
}
