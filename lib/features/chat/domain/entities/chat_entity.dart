class ChatEntity {
  final String message;
  final String timeStamp;
  final String username;

  const ChatEntity({
    required this.message,
    required this.timeStamp,
    required this.username,
  });

  ChatEntity copyWith({
    String? message,
    String? timeStamp,
    String? username,
  }) {
    return ChatEntity(
      message: message ?? this.message,
      timeStamp: timeStamp ?? this.timeStamp,
      username: username ?? this.username,
    );
  }

  factory ChatEntity.empty() {
    return const ChatEntity(message: '', timeStamp: '', username: '');
  }
}
