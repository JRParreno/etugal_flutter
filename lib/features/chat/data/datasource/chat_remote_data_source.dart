import 'package:dio/dio.dart';
import 'package:etugal_flutter/core/env/env.dart';
import 'package:etugal_flutter/core/error/exceptions.dart';
import 'package:etugal_flutter/core/interceptor/api_interceptor.dart';
import 'package:etugal_flutter/features/chat/data/models/index.dart';

abstract class ChatRemoteDataSource {
  Future<ChatMessagesModel> getChats({
    required String sessionId,
    String? next,
  });
  Future<ChatSessionModel> getChatSession(String roomName);
  Future<ChatSessionModel> createChatSession({
    required String roomName,
    required int providerId,
    required int performerId,
    required int taskId,
  });
  Future<ChatListModel> getChatList(String? nextPage);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<ChatSessionModel> createChatSession({
    required String roomName,
    required int providerId,
    required int performerId,
    required int taskId,
  }) async {
    final String url = '$baseUrl/api/chat-sessions';

    final data = {
      "provider_id": providerId,
      "performer_id": performerId,
      "task_id": taskId,
      "room_name": roomName
    };
    try {
      final response = await ApiInterceptor.apiInstance().post(
        url,
        data: data,
      );

      return ChatSessionModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ChatListModel> getChatList(String? nextPage) async {
    String url = '$baseUrl/api/chat-sessions';

    if (nextPage != null) {
      url = nextPage;
    }

    try {
      final response = await ApiInterceptor.apiInstance().get(url);
      return ChatListModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ChatSessionModel> getChatSession(String roomName) async {
    final String url = '$baseUrl/api/chat-session/retrieve?room_name=$roomName';

    try {
      final response = await ApiInterceptor.apiInstance().get(url);
      return ChatSessionModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ChatMessagesModel> getChats(
      {required String sessionId, String? next}) async {
    String url = '$baseUrl/api/chat-messages?session_id=$sessionId';

    if (next != null) {
      url = next;
    }

    // try {
    final response = await ApiInterceptor.apiInstance().get(url);
    return ChatMessagesModel.fromJson(response.data);
    // } on DioException catch (e) {
    //   throw ServerException(
    //     e.response?.data['error_message'] ?? 'Something went wrong.',
    //   );
    // } catch (e) {
    //   throw ServerException(e.toString());
    // }
  }
}
