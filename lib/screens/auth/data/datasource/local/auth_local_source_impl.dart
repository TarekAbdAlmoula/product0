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
    required String phoneNumber,
    required String location,

    String? token,
  }) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
    await _storage.write(key: 'userId', value: userId.toString());
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'accountType', value: accountType);
    await _storage.write(key: 'phoneNumber', value: phoneNumber);
    await _storage.write(key: 'location', value: location);
    if (token != null) await _storage.write(key: 'token', value: token);
  }

  @override
  Future<String> getData(String data) async {
    String? value = await _storage.read(key: data);
    return value ?? '';
  }

  @override
  Future<void> saveSpecificData({required String value}) async {
    await _storage.write(key: 'token', value: value);
  }
}
