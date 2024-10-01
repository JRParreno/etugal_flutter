import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/common/widgets/shimmer_loading.dart';
import 'package:etugal_flutter/core/enums/view_status.dart';
import 'package:etugal_flutter/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart';
import 'package:etugal_flutter/features/chat/presentation/pages/chat_page.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatListBloc>().add(OnGetChatList());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<ChatListBloc>().add(OnGetChatList());
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocBuilder<ChatListBloc, ChatListState>(
          builder: (context, state) {
            if (state.viewStatus == ViewStatus.loading) {
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ShimmerLoading(
                    height: 70,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(12),
                  );
                },
              );
            }

            if (state.viewStatus == ViewStatus.failed) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }

            if (state.viewStatus == ViewStatus.successful) {
              if (state.chatListModel.chatSession.isEmpty) {
                return Center(
                  child: Text(
                    'No chats found',
                    style: textTheme.labelMedium?.copyWith(
                      color: ColorName.darkerGreyFont,
                    ),
                  ),
                );
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  final chat = state.chatListModel.chatSession[index];
                  final profilePhoto =
                      chat.provider.user.username != getUserName()
                          ? chat.provider.profilePhoto
                          : chat.performer.profilePhoto;
                  final profileDetails =
                      chat.provider.user.username != getUserName()
                          ? chat.provider
                          : chat.performer;

                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        AppRoutes.chat.name,
                        extra: ChatArgs(
                          performerId: chat.performer.id,
                          providerId: chat.provider.id,
                          taskEntity: chat.task,
                          chatSession: chat,
                        ),
                      );
                    },
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ColorName.borderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: ColorName.primary,
                                  backgroundImage: profilePhoto != null
                                      ? Image.network(profilePhoto).image
                                      : null,
                                  radius: 25,
                                  child: profilePhoto == null
                                      ? const Icon(
                                          Icons.person_outline,
                                          size: 25 * 0.75,
                                          color: ColorName.whiteNotMuch,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      profileDetails.user.getFullName ?? '',
                                      style: textTheme.labelMedium?.copyWith(
                                        color: ColorName.darkerGreyFont,
                                      ),
                                    ),
                                    Text(
                                      chat.task.title,
                                      style: textTheme.labelSmall?.copyWith(
                                        color: ColorName.darkerGreyFont,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: state.chatListModel.chatSession.length,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  String getUserName() {
    final state = context.read<AppUserCubit>().state;
    if (state is AppUserLoggedIn) {
      return state.user.username;
    }
    return '';
  }
}
