import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:product0/screens/home/data/datasource/local/home_local_source.dart';

class HomeLocalSourceImpl implements HomeLocalSource {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future getLocalData(String key) async {
    String? token = await _storage.read(key: key);
    return token;
  }
}
