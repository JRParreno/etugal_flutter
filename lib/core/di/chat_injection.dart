import 'package:etugal_flutter/features/chat/data/datasource/chat_remote_data_source.dart';
import 'package:etugal_flutter/features/chat/data/repository/chat_repository_impl.dart';
import 'package:etugal_flutter/features/chat/domain/repository/chat_repository.dart';
import 'package:etugal_flutter/features/chat/domain/usecases/index.dart';
import 'package:etugal_flutter/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:etugal_flutter/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart';
import 'package:get_it/get_it.dart';

void initChat(GetIt serviceLocator) {
  serviceLocator
    // Datasource
    ..registerFactory<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(serviceLocator()),
    )
    // Usecase
    ..registerFactory(
      () => CreateChatSession(serviceLocator()),
    )
    ..registerFactory(
      () => GetChatList(serviceLocator()),
    )
    ..registerFactory(
      () => GetChatSession(serviceLocator()),
    )
    ..registerFactory(
      () => GetChats(serviceLocator()),
    )
    // Bloc
    ..registerFactory(
      () => ChatBloc(
        createChatSession: serviceLocator(),
        getChatSession: serviceLocator(),
        getChats: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ChatListBloc(serviceLocator()),
    );
}
