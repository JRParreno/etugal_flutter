import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/enums/view_status.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:etugal_flutter/features/chat/domain/usecases/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final GetChatList _getChatList;

  ChatListBloc(GetChatList getChatList)
      : _getChatList = getChatList,
        super(
          ChatListInitial(
            chatListModel: ChatListEntity.empty(),
          ),
        ) {
    on<OnGetChatList>(_onGetChatList);
    on<OnPaginateChatList>(_onPaginateStudentChatList);
  }

  FutureOr<void> _onGetChatList(
    OnGetChatList event,
    Emitter<ChatListState> emit,
  ) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    final response = await _getChatList.call(null);

    response.fold(
      (l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
      (r) => emit(state.copyWith(
        chatListModel: r,
        viewStatus: ViewStatus.successful,
      )),
    );
  }

  FutureOr<void> _onPaginateStudentChatList(
    OnPaginateChatList event,
    Emitter<ChatListState> emit,
  ) async {
    if (state.viewStatus == ViewStatus.successful) {
      emit(state.copyWith(viewStatus: ViewStatus.isPaginated));

      final response = await _getChatList.call(state.chatListModel.nextPage);

      response.fold(
        (l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
        (r) => emit(
          state.copyWith(
            chatListModel: r.copyWith(
              chatSession: [
                ...state.chatListModel.chatSession,
                ...r.chatSession,
              ],
            ),
            viewStatus: ViewStatus.successful,
          ),
        ),
      );
    }
  }
}
