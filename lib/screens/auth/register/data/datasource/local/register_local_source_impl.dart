import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:product0/screens/auth/register/data/datasource/local/register_local_source.dart';

class RegisterLocalSourceImpl implements RegisterLocalSource {
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
}
