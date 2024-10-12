class UserReportEntity {
  final int id;
  final List<String> images;
  final String reason;
  final String additionalInfo;
  final String status;
  final String actionTaken;
  final String? resolutionNotes;
  final DateTime? resolvedAt;
  final String? suspensionDuration;

  UserReportEntity({
    required this.id,
    required this.images,
    required this.reason,
    required this.additionalInfo,
    required this.status,
    required this.actionTaken,
    this.resolutionNotes,
    this.resolvedAt,
    this.suspensionDuration,
  });
}
