class TaskUserEntity {
  TaskUserEntity({
    required this.pk,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.getFullName,
  });

  final int? pk;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? getFullName;
}
