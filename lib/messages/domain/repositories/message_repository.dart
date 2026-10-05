abstract interface class MessageRepository {
  Future<void> broadcast({
    required String message,
    String? chatId,
  });
}