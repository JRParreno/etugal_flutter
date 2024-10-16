import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/enums/view_status.dart';
import 'package:etugal_flutter/features/chat/domain/entities/index.dart';
import 'package:etugal_flutter/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:etugal_flutter/features/chat/presentation/pages/widgets/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

    textEditingController.addListener(() {
      isDisabled.value = textEditingController.value.text.trim().isEmpty;
    });

    handleEventScrollListener();

    // initialize websocket channel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initChannel();
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
        title: BlocSelector<ChatBloc, ChatState, ChatSessionEntity?>(
          selector: (state) {
            return state.chatSession;
          },
          builder: (context, state) {
            final chatSession = state;
            if (chatSession == null) return const SizedBox.shrink();
            final chatUser = chatSession.provider.user.username != getUserName()
                ? chatSession.provider
                : chatSession.performer;
            return Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorName.primary,
                  backgroundImage: chatUser.profilePhoto != null
                      ? Image.network(chatUser.profilePhoto!).image
                      : null,
                  radius: 20,
                  child: chatUser.profilePhoto == null
                      ? const Icon(
                          Icons.person_outline,
                          size: 20 * 0.75,
                          color: ColorName.whiteNotMuch,
                        )
                      : null,
                ),
                const SizedBox(width: 10),
                Text(
                  chatUser.user.getFullName ?? '',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              final chatUser =
                  chatSession?.provider.user.username != getUserName()
                      ? chatSession?.provider
                      : chatSession?.performer;
              if (chatUser != null && chatUser.report == null) {
                context.pushNamed(AppRoutes.chatReportUser.name,
                    extra: {"id": chatUser.user.pk});
                return;
              }
              handleReportMessage();
            },
            icon: const Icon(Icons.error),
          ),
        ],
      ),
      body: Expanded(
        child: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state.chatSession != null) {
              setState(() {
                chatSession = state.chatSession;
              });
            }

            if (state.viewStatus == ViewStatus.failed) {
              onFormError(state.errorMessage ?? 'Something went wrong');
            }
          },
          builder: (context, state) {
            if (state.viewStatus == ViewStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.viewStatus == ViewStatus.failed) {
              return Center(child: Text(state.errorMessage ?? ''));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.104,
                  child: Card(
                    color: ColorName.whiteNotMuch,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.args.taskEntity.title,
                            style: textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Reward: PHP ${widget.args.taskEntity.reward}',
                            style: textTheme.labelLarge
                                ?.copyWith(color: ColorName.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.viewStatus.name == ViewStatus.isPaginated.name) ...[
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),
                ],
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
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
                if (!isCanChat()) ...[
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
                ] else ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorName.primary)),
                    child: const Text(
                      'This account is either suspended or terminated',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
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
      const serverHost = 'etugal-core.onrender.com';
      // wss for https otherwise http ws
      wsUrl = Uri.parse('wss://$serverHost/ws/chat/$roomName/');
      channel = IOWebSocketChannel.connect(wsUrl);
      displaySnackbar("Websocket: connecting");
      await channel.ready;

      if (mounted) {
        // set isConnected to true when already connected to websocket otherwise false

        // ignore: use_build_context_synchronously
        context
            .read<ChatBloc>()
            .add(const OnGetConnectWebSocket(isConnected: true));
      }
      displaySnackbar("Websocket: connected");

      channel.stream.listen((message) {
        context.read<ChatBloc>().add(OnReceivedMessageChat(message: message));
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      context
          .read<ChatBloc>()
          .add(const OnGetConnectWebSocket(isConnected: false));
      displaySnackbar("Websocket: ${e.toString()}");
    }
  }

  String getUserName() {
    final state = context.read<AppUserCubit>().state;
    if (state is AppUserLoggedIn) {
      return state.user.username;
    }
    return '';
  }

  void handleEventScrollListener() {
    scrollController.addListener(
      () {
        if (scrollController.position.pixels >
            (scrollController.position.pixels * 0.75)) {
          context.read<ChatBloc>().add(
                OnPaginateChat(),
              );
        }
      },
    );
  }

  void handleReportMessage() {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: 'E-Tugal',
        message:
            'You already report this user please wait for the admin to review.',
      );
    });
  }

  bool isCanChat() {
    final performer = widget.args.chatSession?.performer;
    final provider = widget.args.chatSession?.provider;

    return (performer?.isSuspeneded ?? false) ||
        (performer?.isTerminated ?? false) ||
        (provider?.isSuspeneded ?? false) ||
        (provider?.isTerminated ?? false);
  }

  void onFormError(String message) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: 'E-Tugal',
        message: message,
      ).whenComplete(() {
        context.pop();
      });
    });
  }

  void displaySnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
