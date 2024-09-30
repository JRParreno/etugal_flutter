part of 'chat_list_bloc.dart';

class ChatListState extends Equatable {
  final ChatListEntity chatListModel;
  final ViewStatus viewStatus;

  const ChatListState({
    required this.chatListModel,
    this.viewStatus = ViewStatus.none,
  });

  @override
  List<Object> get props => [chatListModel, viewStatus];

  ChatListState copyWith({
    ChatListEntity? chatListModel,
    ViewStatus? viewStatus,
  }) {
    return ChatListState(
      chatListModel: chatListModel ?? this.chatListModel,
      viewStatus: viewStatus ?? this.viewStatus,
    );
  }
}

final class ChatListInitial extends ChatListState {
  const ChatListInitial({required super.chatListModel});
}
