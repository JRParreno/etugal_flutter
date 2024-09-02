enum VerificationStatus {
  processingApplication,
  verified,
  rejected,
  unverified
}

VerificationStatus getVerificationStatusFromString(String status) {
  switch (status) {
    case 'PROCESSING_APPLICATION':
      return VerificationStatus.processingApplication;
    case 'VERIFIED':
      return VerificationStatus.verified;
    case 'REJECTED':
      return VerificationStatus.rejected;
    case 'UNVERIFIED':
      return VerificationStatus.unverified;
    default:
      throw Exception('Unknown status: $status');
  }
}
