import 'package:product0/screens/auth/register/data/model/user.dart';

abstract class RegisterRepository {
  Future createNewUser({required User user});
  Future verifyOtp({required String otp, required num userId});
  // Future saveUserData({
  //   required String userId,
  //   required String username,
  //   required String password,
  // });
}
