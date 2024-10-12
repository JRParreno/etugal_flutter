import 'package:dio/dio.dart';
import 'package:etugal_flutter/core/env/env.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/interceptor/api_interceptor.dart';
import 'package:etugal_flutter/features/chat/data/models/index.dart';
import 'package:image_picker/image_picker.dart';

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
  Future<bool> createReportUser({
    required int reportedUserId,
    required String reason,
    List<XFile>? images,
    String? additionalInfo,
  });
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
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
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
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<ChatSessionModel> getChatSession(String roomName) async {
    final String url = '$baseUrl/api/chat-session/retrieve?room_name=$roomName';

    try {
      final response = await ApiInterceptor.apiInstance().get(url);
      return ChatSessionModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<ChatMessagesModel> getChats(
      {required String sessionId, String? next}) async {
    String url = '$baseUrl/api/chat-messages?session_id=$sessionId';

    if (next != null) {
      url = next;
    }

    try {
      final response = await ApiInterceptor.apiInstance().get(url);
      return ChatMessagesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  @override
  Future<bool> createReportUser({
    required String reason,
    List<XFile>? images,
    String? additionalInfo,
    int reportedUserId = 0, // Add reportedUserId parameter if needed
  }) async {
    final String url = '$baseUrl/api/reports/';
    DateTime dateToday = DateTime.now();

    // Create a list to hold the image files for the multipart form data
    List<MultipartFile> imageFiles = [];

    if (images != null) {
      for (var image in images) {
        String fileName = '$dateToday - ${image.path.split('/').last}';
        imageFiles.add(
          await MultipartFile.fromFile(image.path, filename: fileName),
        );
      }
    }

    // Create FormData with the images, reason, additional info, and reported user
    final data = FormData.fromMap(
      {
        "images": imageFiles, // Map the images here
        "reason": reason,
        "additional_info": additionalInfo ?? "",
        "reported_user": reportedUserId, // Include the reported user ID
      },
    );

    try {
      await apiInstance.post(
        url,
        data: data,
        options: Options(
          contentType: "multipart/form-data",
        ),
      );

      return true;
    } on DioException catch (e) {
      throw Failure(
        e.message ?? "Something went wrong",
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
