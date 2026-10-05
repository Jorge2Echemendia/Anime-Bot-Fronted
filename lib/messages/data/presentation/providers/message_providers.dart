import 'package:anime_bot_fronted/messages/data/datasources/message_remote_data_source.dart';
import 'package:anime_bot_fronted/messages/data/repositories/message_repository_impl.dart';
import 'package:anime_bot_fronted/messages/domain/repositories/message_repository.dart';
import 'package:anime_bot_fronted/messages/domain/use_cases/broadcast_message_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/global_providers.dart';

final messageRemoteDataSourceProvider =
    Provider<MessageRemoteDataSource>((ref) {
  return MessageRemoteDataSource(ref.watch(apiClientProvider));
});

final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  return MessageRepositoryImpl(ref.watch(messageRemoteDataSourceProvider));
});

final broadcastMessageUseCaseProvider =
    Provider<BroadcastMessageUseCase>((ref) {
  return BroadcastMessageUseCase(ref.watch(messageRepositoryProvider));
});