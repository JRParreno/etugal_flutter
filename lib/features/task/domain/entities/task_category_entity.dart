class TaskCategoryEntity {
  TaskCategoryEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
  });

  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;

  factory TaskCategoryEntity.empty() {
    return TaskCategoryEntity(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      id: -1,
      title: 'Explore',
    );
  }
}
