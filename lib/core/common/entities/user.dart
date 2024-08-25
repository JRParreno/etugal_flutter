class User {
  final String pk;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePk;
  final String? profilePhoto;
  final int age;

  User({
    required this.pk,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePk,
    required this.age,
    this.profilePhoto,
  });
}
