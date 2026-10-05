import '../../../../core/network/api_client.dart';

class MessageRemoteDataSource {
  final ApiClient _client;
  MessageRemoteDataSource(this._client);

  Future<void> broadcast({
    required String message,
    String? chatId,
  }) async {
    await _client.post(
      '/messages',
      body: {
        'message': message,
        if (chatId != null) 'chatId': chatId,
      },
    );
  }
}