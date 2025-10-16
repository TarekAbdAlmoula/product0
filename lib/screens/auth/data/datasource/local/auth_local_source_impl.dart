import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:product0/screens/auth/data/datasource/local/auth_local_source.dart';

class AuthLocalSourceImpl implements AuthLocalSource {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<void> saveUserData({
    required String username,
    required String password,
    required num userId,
    required String email,
    required String accountType,
  }) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
    await _storage.write(key: 'userId', value: userId.toString());
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'accountType', value: accountType);
  }

  @override
  Future<String> getData(String data) async {
    String? value = await _storage.read(key: data);
    return value ?? 'This key is empty';
  }

  @override
  Future<void> saveSpecificData({required String value}) async {
    await _storage.write(key: 'token', value: value);
  }
}
