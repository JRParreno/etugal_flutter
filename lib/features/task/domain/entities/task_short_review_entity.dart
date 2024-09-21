class TaskShortReviewEntity {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int providerRate;
  final String providerFeedback;
  final int performerRate;
  final String performerFeedback;

  TaskShortReviewEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.providerRate,
    required this.providerFeedback,
    required this.performerRate,
    required this.performerFeedback,
  });
}
