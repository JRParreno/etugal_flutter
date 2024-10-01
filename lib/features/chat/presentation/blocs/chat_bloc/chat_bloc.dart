import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/enums/view_status.dart';
import 'package:etugal_flutter/features/chat/data/models/chat_model.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:etugal_flutter/features/chat/domain/usecases/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final CreateChatSession _createChatSession;
  final GetChatSession _getChatSession;
  final GetChats _getChats;

  ChatBloc({
    required CreateChatSession createChatSession,
    required GetChatSession getChatSession,
    required GetChats getChats,
  })  : _createChatSession = createChatSession,
        _getChatSession = getChatSession,
        _getChats = getChats,
        super(ChatInitial()) {
    on<OnTryConnectToWebSocket>(_onTryConnectToWebSocket);

    on<OnGetInitialChat>(_onGetInitialChat);
    on<OnReceivedMessageChat>(_onReceivedMessageChat);
    on<OnGetConnectWebSocket>(_onGetConnectWebSocket);
    on<OnPaginateChat>(_onPaginateChat);
  }

  FutureOr<void> _onTryConnectToWebSocket(
    OnTryConnectToWebSocket event,
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(viewStatus: ViewStatus.loading),
    );
  }

  FutureOr<void> _onGetConnectWebSocket(
    OnGetConnectWebSocket event,
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(
        isWebSocketConnected: event.isConnected,
        viewStatus: ViewStatus.successful,
      ),
    );
  }

  FutureOr<void> _onReceivedMessageChat(
    OnReceivedMessageChat event,
    Emitter<ChatState> emit,
  ) async {
    final chats = [...state.chats.chats];
    Map<String, dynamic> json = jsonDecode(event.message);

    emit(ChatState(
        chats: state.chats.copyWith(chats: [
      ChatModel(
        message: json['message'],
        timeStamp: json['time_stamp'],
        username: json['username'],
      ),
      ...chats
    ])));
  }

  FutureOr<void> _onGetInitialChat(
    OnGetInitialChat event,
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(
        viewStatus: ViewStatus.loading,
      ),
    );

    ChatSessionEntity? chatSession;

    if (event.chatSession == null) {
      final chatSeesionResponse = await _getChatSession.call(event.roomName);

      chatSeesionResponse.fold((l) {
        if (l.message.toLowerCase() != "not found") {
          return emit(state.copyWith(viewStatus: ViewStatus.failed));
        }
      }, (r) {
        chatSession = r;
      });
    }

    if (chatSession == null) {
      final createChatSessionResponse = await _createChatSession.call(
        CreateChatSessionParams(
          roomName: event.roomName,
          providerId: event.providerId,
          performerId: event.performerId,
          taskId: event.taskId,
        ),
      );

      createChatSessionResponse.fold((l) {
        if (l.message.toLowerCase() != "not found") {
          return emit(state.copyWith(viewStatus: ViewStatus.failed));
        }
      }, (r) {
        chatSession = r;
      });
    }

    final chatResponse = await _getChats.call(
      GetChatsParams(sessionId: chatSession!.id.toString()),
    );

    chatResponse.fold(
      (l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
      (r) => emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          chatSession: chatSession,
          chats: r,
        ),
      ),
    );
  }

  FutureOr<void> _onPaginateChat(
    OnPaginateChat event,
    Emitter<ChatState> emit,
  ) async {
    if (state.viewStatus != ViewStatus.isPaginated &&
        state.chats.nextPage != null) {
      final response = await _getChats.call(
        GetChatsParams(
          sessionId: state.chatSession?.id.toString() ?? '',
          next: state.chats.nextPage,
        ),
      );

      response.fold(
        (l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
        (r) => emit(
          state.copyWith(
            viewStatus: ViewStatus.isPaginated,
            chats: r.copyWith(
              chats: [...state.chats.chats, ...r.chats],
            ),
          ),
        ),
      );
    }
  }
}
