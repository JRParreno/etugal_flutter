enum WorkType { inPerson, online }

WorkType getWorkTypeFromString(String status) {
  switch (status) {
    case 'IN_PERSON':
      return WorkType.inPerson;
    case 'ONLINE':
      return WorkType.online;
    default:
      throw Exception('Unknown status: $status');
  }
}

String getWorkTypeFromEnum(WorkType status) {
  switch (status) {
    case WorkType.inPerson:
      return 'IN_PERSON';
    case WorkType.online:
      return 'ONLINE';
    default:
      throw Exception('Unknown status: $status');
  }
}
