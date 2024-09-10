enum TaskStatusEnum {
  pending,
  inProgres,
  accepted,
  competed,
  canceled,
  rejected,
}

TaskStatusEnum getTaskStatusFromString(String status) {
  switch (status) {
    case 'PENDING':
      return TaskStatusEnum.pending;
    case 'IN_PROGRESS':
      return TaskStatusEnum.inProgres;
    case 'ACCEPTED':
      return TaskStatusEnum.accepted;
    case 'COMPLETED':
      return TaskStatusEnum.competed;
    case 'CANCELLED':
      return TaskStatusEnum.canceled;
    case 'REJECTED':
      return TaskStatusEnum.rejected;
    default:
      throw Exception('Unknown status: $status');
  }
}

String getTaskStatusFromEnum(TaskStatusEnum status) {
  switch (status) {
    case TaskStatusEnum.pending:
      return 'PENDING';
    case TaskStatusEnum.inProgres:
      return 'IN_PROGRESS';
    case TaskStatusEnum.accepted:
      return 'ACCEPTED';
    case TaskStatusEnum.competed:
      return 'COMPLETED';
    case TaskStatusEnum.canceled:
      return 'CANCELLED';
    case TaskStatusEnum.rejected:
      return 'REJECTED';
    default:
      throw Exception('Unknown status: $status');
  }
}
