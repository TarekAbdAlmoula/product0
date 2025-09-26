import 'package:product0/screens/auth/register/data/model/user.dart';

abstract class RegisterRemoteSource {
  Future createNewUser({required User user});
  Future verifyOtp({required String otp, required num userId});
}
