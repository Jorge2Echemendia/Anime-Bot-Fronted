import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/secure_storage.dart';



final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage(const FlutterSecureStorage());
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(secureStorageProvider));
});

// ============ CASOS DE USO (Auth) ============
// Los definiremos en auth_providers.dart

// ============ CASOS DE USO (Users) ============
// Los definiremos en user_providers.dart