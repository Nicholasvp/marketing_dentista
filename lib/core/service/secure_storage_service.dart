import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final secureStorage = const FlutterSecureStorage();
  Future<void> write(String key, String value) async {
    secureStorage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return secureStorage.read(key: key);
  }

  Future<void> delete(String key) async {
    secureStorage.delete(key: key);
  }
}
