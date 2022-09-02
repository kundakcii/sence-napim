import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStoreService extends FlutterSecureStorage {
  final storage = const FlutterSecureStorage();
  Future<void> storeValue({required String key, required String value}) async {
    return await storage.write(key: key, value: value);
  }

  Future<String?> readValue({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> deletAllValues() async {
    await storage.deleteAll();
  }
}
