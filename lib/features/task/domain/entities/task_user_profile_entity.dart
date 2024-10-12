// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/features/profile/domain/entities/user_report_entity.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskUserProfileEntity {
  TaskUserProfileEntity({
    required this.id,
    required this.user,
    required this.birthdate,
    required this.address,
    required this.contactNumber,
    required this.gender,
    required this.verificationStatus,
    required this.isTerminated,
    required this.terminationReason,
    required this.isSuspeneded,
    required this.suspensionReason,
    this.profilePhoto,
    this.verificationRemarks,
    this.idPhoto,
    this.facePhoto,
    this.description,
    this.suspendedUntil,
    this.report,
  });

  final int id;
  final TaskUserEntity user;
  final DateTime birthdate;
  final String address;
  final String contactNumber;
  final String gender;
  final String verificationStatus;
  final String? profilePhoto;
  final String? verificationRemarks;
  final String? idPhoto;
  final String? facePhoto;
  final String? description;
  final bool isSuspeneded;
  final String? suspensionReason;
  final DateTime? suspendedUntil;
  final bool isTerminated;
  final String? terminationReason;
  final UserReportEntity? report;
}
