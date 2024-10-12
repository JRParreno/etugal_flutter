import 'package:etugal_flutter/features/profile/domain/entities/user_report_entity.dart';

class UserReportModel extends UserReportEntity {
  UserReportModel({
    required super.id,
    required super.images,
    required super.reason,
    required super.additionalInfo,
    required super.status,
    required super.actionTaken,
    required super.resolutionNotes,
    super.resolvedAt,
    super.suspensionDuration,
  });

  factory UserReportModel.fromJson(Map<String, dynamic> map) {
    final imageList = List<Map<String, dynamic>>.from(map['images_list'] ?? []);
    final images = imageList.isNotEmpty
        ? imageList.map((value) => value['image'] as String).toList()
        : <String>[];

    return UserReportModel(
      id: map['id'] as int,
      images: images,
      reason: map['reason'] as String,
      additionalInfo: map['additional_info'] as String,
      status: map['status'] as String,
      actionTaken: map['action_taken'] as String,
      resolutionNotes: map['resolution_notes'],
      resolvedAt: map['resolved_at'] != null
          ? DateTime.parse(map['resolved_at'])
          : null,
      suspensionDuration: map['suspension_duration'] != null
          ? map['suspension_duration'] as String
          : null,
    );
  }
}
