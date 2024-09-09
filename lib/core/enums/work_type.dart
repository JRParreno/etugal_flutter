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
