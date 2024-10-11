import 'dart:convert';

import 'package:etugal_flutter/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.pk,
    required super.username,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.profilePk,
    required super.contactNumber,
    required super.address,
    required super.gender,
    required super.verificationStatus,
    required super.birthdate,
    super.verificationRemarks,
    super.profilePhoto,
    super.idPhoto,
  });

  factory UserModel.empty() {
    return UserModel(
      pk: '',
      username: '',
      firstName: '',
      lastName: '',
      email: '',
      profilePk: '',
      address: '',
      contactNumber: '',
      gender: '',
      verificationStatus: '',
      profilePhoto: '',
      verificationRemarks: '',
      idPhoto: '',
      birthdate: DateTime.now(),
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      pk: map['pk'] as String,
      username: map['username'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      profilePk: map['profilePk'] as String,
      contactNumber: map['contactNumber'] as String,
      address: map['address'] as String,
      gender: map['gender'] as String,
      verificationStatus: map['verificationStatus'] as String,
      verificationRemarks: map['verificationRemarks'] != null
          ? map['verificationRemarks'] as String
          : null,
      profilePhoto:
          map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
      idPhoto: map['idPhoto'] != null ? map['idPhoto'] as String : null,
      birthdate: DateTime.parse(map['birthdate']),
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
