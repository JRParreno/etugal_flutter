enum TaskStatusEnum {
  prending,
  inProgres,
  accepted,
  competed,
  canceled,
  rejected,
}

TaskStatusEnum getVerificationStatusFromString(String status) {
  switch (status) {
    case 'PENDING':
      return TaskStatusEnum.prending;
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

String getVerificationStatusFromEnum(TaskStatusEnum status) {
  switch (status) {
    case TaskStatusEnum.prending:
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
