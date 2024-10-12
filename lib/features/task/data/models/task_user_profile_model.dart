import 'package:etugal_flutter/features/profile/data/models/user_report_model.dart';
import 'package:etugal_flutter/features/task/data/models/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskUserProfileModel extends TaskUserProfileEntity {
  TaskUserProfileModel({
    required super.id,
    required super.user,
    required super.birthdate,
    required super.address,
    required super.contactNumber,
    required super.gender,
    required super.profilePhoto,
    required super.verificationStatus,
    required super.verificationRemarks,
    required super.idPhoto,
    required super.facePhoto,
    required super.description,
    required super.isTerminated,
    required super.terminationReason,
    required super.isSuspeneded,
    required super.suspensionReason,
    super.suspendedUntil,
    super.report,
  });

  factory TaskUserProfileModel.fromJson(Map<String, dynamic> json,
      [String? description]) {
    return TaskUserProfileModel(
      id: json["id"],
      user: TaskUserModel.fromJson(json["user"]),
      birthdate: DateTime.parse(json["birthdate"]),
      address: json["address"],
      contactNumber: json["contact_number"],
      gender: json["gender"],
      profilePhoto: json["profile_photo"],
      verificationStatus: json["verification_status"],
      verificationRemarks: json["verification_remarks"],
      idPhoto: json["id_photo"],
      facePhoto: json["face_photo"],
      description: description,
      suspensionReason: json['suspension_reason'],
      terminationReason: json['termination_reason'],
      isSuspeneded: json['is_suspended'] as bool,
      isTerminated: json['is_terminated'] as bool,
      suspendedUntil: json['suspended_until'] != null
          ? DateTime.parse(json['suspended_until'])
          : null,
      report: json['report'] != null
          ? UserReportModel.fromJson(json['report'])
          : null,
    );
  }
}
