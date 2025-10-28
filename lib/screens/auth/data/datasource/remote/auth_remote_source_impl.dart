import 'package:dio/dio.dart';
import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/core/utils/error_handler.dart';
import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/auth/data/datasource/remote/auth_remote_source.dart';
import 'package:product0/screens/auth/data/model/user.dart';

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final ApiConsumer api;
  AuthRemoteSourceImpl({required this.api});
  @override
  Future createNewUser({required User user}) async {
    try {
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
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع أثناء التسجيل");
    }
  }

  @override
  Future verifyOtp({required String otp, required String userId}) async {
    var response = await api.post(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/verify-otp',
      data: {"user_id": int.parse(userId), "otp": otp},
    );
    return response;
  }

  @override
  Future login({required String email, required String password}) async {
    try {
      var response = await api.post(
        'https://wasla.barmijha.net/wp-json/jwt-auth/v1/token',
        data: {"username": email, "password": password},
      );

      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع أثناء التسجيل");
    }
  }

  @override
  Future addPoints({required String action, required String token}) async {
    var response = await api.post(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/user_points',
      data: {"action": action},
      token: token,
    );
    print(' points response ${response['message']}');
    return response['message'];
  }
}
