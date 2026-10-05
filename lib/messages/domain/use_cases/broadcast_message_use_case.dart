import '../repositories/message_repository.dart';

class BroadcastMessageUseCase {
  final MessageRepository _repository;
  BroadcastMessageUseCase(this._repository);

  Future<void> call({
    required String message,
    String? chatId,
  }) {
    final trimmed = message.trim();

    if (trimmed.isEmpty) {
      throw ArgumentError('El mensaje no puede estar vacío');
    }
    if (trimmed.length > 4096) {
      throw ArgumentError('El mensaje supera el límite de 4096 caracteres');
    }
    return _repository.broadcast(message: trimmed, chatId: chatId);
  }
}