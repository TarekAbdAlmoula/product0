import 'package:product0/screens/auth/data/model/user.dart';

abstract class AuthRepository {
  Future createNewUser({required User user});
  Future verifyOtp({required String otp});
  Future login({required String email, required String password});
  Future addPoints({required String action});
  Future getLocalData({required String key});
}
