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
    this.verificationRemarks,
    this.idPhoto,
    this.facePhoto,
    this.description,
    this.profilePhoto,
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
}
