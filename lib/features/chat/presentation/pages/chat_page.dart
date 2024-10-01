import 'dart:convert';

import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/enums/view_status.dart';
import 'package:etugal_flutter/core/env/env.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:etugal_flutter/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:etugal_flutter/features/chat/presentation/pages/widgets/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatArgs {
  final ChatSessionEntity? chatSession;
  final TaskEntity taskEntity;
  final int providerId;
  final int performerId;

  ChatArgs({
    required this.performerId,
    required this.providerId,
    required this.taskEntity,
    this.chatSession,
  });
}

class ChatPage extends StatefulWidget {
  final ChatArgs args;
  static const String routeName = '/chat';

  const ChatPage({
    super.key,
    required this.args,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Uri wsUrl;
  late IOWebSocketChannel channel;
  final TextEditingController textEditingController = TextEditingController();
  ValueNotifier<bool> isDisabled = ValueNotifier(true);
  ChatSessionEntity? chatSession;
  final ScrollController scrollController = ScrollController();
  String roomName = '';

  @override
  void initState() {
    super.initState();

    chatSession = widget.args.chatSession;
    final performerId = widget.args.performerId;
    final providerId = widget.args.providerId;
    final taskId = widget.args.taskEntity.id;
    roomName = '$performerId-$providerId-$taskId';

    context.read<ChatBloc>().add(
          OnGetInitialChat(
            roomName: roomName,
            performerId: widget.args.performerId,
            providerId: widget.args.providerId,
            taskId: widget.args.taskEntity.id,
            chatSession: chatSession,
          ),
        );
    // initialize websocket channel
    initChannel();

    textEditingController.addListener(() {
      isDisabled.value = textEditingController.value.text.trim().isEmpty;
    });
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close(status.goingAway);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.args.taskEntity.title,
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state.chatSession != null) {
            setState(() {
              chatSession = state.chatSession;
            });
          }
        },
        builder: (context, state) {
          if (state.viewStatus == ViewStatus.loading) {
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          return SizedBox.expand(
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final chat = state.chats.chats[index];

                      return ChatBubble(
                        isSender: getUserName() == chat.username,
                        message: chat.message,
                        timeStamp: chat.timeStamp,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: state.chats.chats.length,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: isDisabled,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return ChatInput(
                      controller: textEditingController,
                      onSend: (value) {
                        onSendChatMessage(value);
                      },
                      isDisabled: value,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> onSendChatMessage(String message) async {
    if (message.isNotEmpty && chatSession != null) {
      final Map<String, dynamic> data = {
        "message": message,
        "username": getUserName(),
        "id": chatSession!.id
      };
      channel.sink.add(json.encode(data));
      textEditingController.clear();
    }
  }

  Future<void> initChannel() async {
    // set loading when trying to connect in websocket
    context.read<ChatBloc>().add(OnTryConnectToWebSocket());

    try {
      const serverHost = Env.serverHost;
      // wss for https otherwise http ws
      wsUrl = Uri.parse('ws://$serverHost/ws/chat/$roomName/');
      channel = IOWebSocketChannel.connect(wsUrl);

      await channel.ready;

      if (mounted) {
        // set isConnected to true when already connected to websocket otherwise false

        context
            .read<ChatBloc>()
            .add(const OnGetConnectWebSocket(isConnected: true));
      }

      channel.stream.listen((message) {
        context.read<ChatBloc>().add(OnReceivedMessageChat(message: message));
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      context
          .read<ChatBloc>()
          .add(const OnGetConnectWebSocket(isConnected: false));
    }
  }

  String getUserName() {
    final state = context.read<AppUserCubit>().state;
    if (state is AppUserLoggedIn) {
      return state.user.username;
    }
    return '';
  }
}
