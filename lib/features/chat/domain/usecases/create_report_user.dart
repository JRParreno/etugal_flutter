import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/chat/domain/repository/chat_repository.dart';

import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

class ChatReportUser implements UseCase<bool, ChatReportUserParams> {
  final ChatRepository repository;

  const ChatReportUser(this.repository);

  @override
  Future<Either<Failure, bool>> call(ChatReportUserParams params) async {
    return await repository.createReportUser(
      reason: params.reason,
      reportedUserId: params.reportedUserId,
      additionalInfo: params.additionalInfo,
      images: params.images,
    );
  }
}

class ChatReportUserParams {
  final int reportedUserId;
  final String reason;
  final List<XFile>? images;
  final String? additionalInfo;

  ChatReportUserParams({
    required this.reportedUserId,
    required this.reason,
    this.images,
    this.additionalInfo,
  });
}
