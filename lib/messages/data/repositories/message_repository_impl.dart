import '../../domain/repositories/message_repository.dart';
import '../datasources/message_remote_data_source.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource _remote;
  MessageRepositoryImpl(this._remote);

  @override
  Future<void> broadcast({
    required String message,
    String? chatId,
  }) {
    return _remote.broadcast(message: message, chatId: chatId);
  }
}