// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String pk;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePk;
  final String contactNumber;
  final String address;
  final String gender;
  final String verificationStatus;
  final String? verificationRemarks;
  final String? profilePhoto;
  final String? idPhoto;
  final DateTime birthdate;
  final bool isSuspeneded;
  final String? suspensionReason;
  final DateTime? suspendedUntil;
  final bool isTerminated;
  final String? terminationReason;

  User({
    required this.pk,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePk,
    required this.contactNumber,
    required this.address,
    required this.gender,
    required this.verificationStatus,
    required this.birthdate,
    required this.suspensionReason,
    required this.terminationReason,
    this.isSuspeneded = false,
    this.isTerminated = false,
    this.suspendedUntil,
    this.verificationRemarks,
    this.profilePhoto,
    this.idPhoto,
  });

  User copyWith({
    String? pk,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? profilePk,
    String? contactNumber,
    String? address,
    String? gender,
    String? verificationStatus,
    String? verificationRemarks,
    String? profilePhoto,
    String? idPhoto,
    DateTime? birthdate,
    bool? isSuspeneded,
    String? suspensionReason,
    DateTime? suspendedUntil,
    bool? isTerminated,
    String? terminationReason,
  }) {
    return User(
      pk: pk ?? this.pk,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profilePk: profilePk ?? this.profilePk,
      contactNumber: contactNumber ?? this.contactNumber,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      verificationRemarks: verificationRemarks ?? this.verificationRemarks,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      idPhoto: idPhoto ?? this.idPhoto,
      birthdate: birthdate ?? this.birthdate,
      isSuspeneded: isSuspeneded ?? this.isSuspeneded,
      suspensionReason: suspensionReason ?? this.suspensionReason,
      suspendedUntil: suspendedUntil ?? this.suspendedUntil,
      isTerminated: isTerminated ?? this.isTerminated,
      terminationReason: terminationReason ?? this.terminationReason,
    );
  }
}
