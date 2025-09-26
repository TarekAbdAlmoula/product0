import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/screens/auth/register/data/datasource/remote/register_remote_Source.dart';
import 'package:product0/screens/auth/register/data/model/user.dart';

class RegisterRemoteSourceImpl implements RegisterRemoteSource {
  final ApiConsumer api;
  RegisterRemoteSourceImpl({required this.api});
  @override
  Future createNewUser({required User user}) async {
    var response = await api.post(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/register',
      data: {
        "email": user.email,
        "password": user.password,
        "first_name": user.firstName,
        "last_name": user.lastName,
        "account_type": user.userType,
        "phone_number": user.phoneNumber,
      },
    );
    return response;
  }

  @override
  Future verifyOtp({required String otp, required num userId}) async {
    var response = await api.post(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/verify-otp',
      data: {"user_id": userId, "otp": otp},
    );
    return response;
  }
  Future login({required String username, required String password}) async {
    var response = await api.post(
      'https://wasla.barmijha.net/wp-json/jwt-auth/v1/token',
      data: {
        "username": username,
        "password": password,
      },
    );
    return response;
  }
}
