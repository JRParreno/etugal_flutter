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
    this.verificationRemarks,
    this.profilePhoto,
  });
}
