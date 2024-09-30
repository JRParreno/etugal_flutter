part of 'chat_list_bloc.dart';

sealed class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object> get props => [];
}

class OnGetChatList extends ChatListEvent {}

class OnPaginateChatList extends ChatListEvent {}
