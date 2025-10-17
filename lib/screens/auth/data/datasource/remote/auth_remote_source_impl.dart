import 'package:dio/dio.dart';
import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/screens/auth/data/datasource/remote/auth_remote_source.dart';
import 'package:product0/screens/auth/data/model/user.dart';

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final ApiConsumer api;
  AuthRemoteSourceImpl({required this.api});
  @override
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Registers a new user on the server.
  ///
  /// The [User] object is used to construct the request body.
  ///
  /// The response is the JSON response from the server.
  ///
  /// Returns a Future that completes with the JSON response from the server.
  /*******  55519016-5122-43bb-8d7a-f0e28a93543a  *******/
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
  Future verifyOtp({required String otp, required String userId}) async {
    var response = await api.post(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/verify-otp',
      data: {"user_id": int.parse(userId), "otp": otp},
    );
    if (response['success'] == true) {
      // await addPoints(action: 'first_signup', token: response['token']);
      return response['token'];
    }
  }

  @override
  Future login({required String email, required String password}) async {
    try {
      var response = await api.post(
        'https://wasla.barmijha.net/wp-json/jwt-auth/v1/token',
        data: {"username": email, "password": password},
      );
      final User user = User.fromJson(response);
      print('$user');

      return user;
    } on DioException catch (e) {}
  }

  @override
  Future addPoints({required String action, required String token}) {
    var response = api.post(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/user_points',
      data: {"action": action},
      token: token,
    );
    return response;
  }
}
