import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/auth/data/datasource/local/auth_local_source_impl.dart';
import 'package:product0/screens/auth/data/datasource/remote/auth_remote_source_impl.dart';
import 'package:product0/screens/auth/data/model/auth_response.dart';
import 'package:product0/screens/auth/data/model/user.dart';
import 'package:product0/screens/auth/data/repository/register_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSourceImpl authRemoteSourceImpl;
  final AuthLocalSourceImpl authLocalSourceImpl;
  AuthRepositoryImpl({
    required this.authRemoteSourceImpl,
    required this.authLocalSourceImpl,
  });

  @override
  Future createNewUser({required User user}) async {
    try {
      var response = await authRemoteSourceImpl.createNewUser(user: user);
      final AuthResponse authResponse = AuthResponse.fromJson(response);
      if (authResponse.isSuccess == true) {
        authLocalSourceImpl.saveUserData(
          username: user.firstName ?? '',
          password: user.password ?? '',
          userId: authResponse.userId,
          email: user.email ?? '',
          accountType: user.userType ?? '',
          phoneNumber: user.phoneNumber ?? '',
          location: user.location ?? '',
        );
      }
      return authResponse;
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future login({required String email, required String password}) async {
    try {
      var response = await authRemoteSourceImpl.login(
        email: email,
        password: password,
      );

      if (response['success'] == true) {
        final User user = User.fromJson(response);
        await authLocalSourceImpl.saveUserData(
          username: user.firstName ?? '',
          password: user.password ?? '',
          userId: user.userId ?? 0,
          email: user.email ?? '',
          accountType: user.userType ?? '',
          token: user.token,
          location: user.location ?? '',
          phoneNumber: user.phoneNumber ?? '',
        );
        return true;
      } else if (response['success'] == false) {
        AuthResponse authResponse = AuthResponse.fromJson(response);
        return authResponse;
      }
    } on ServerException catch (e) {
      throw e.message;
    }
  }

  @override
  Future verifyOtp({required String otp}) async {
    String userId = await authLocalSourceImpl.getData('userId');
    var response = await authRemoteSourceImpl.verifyOtp(
      otp: otp,
      userId: userId,
    );
    final AuthResponse authResponse = AuthResponse.fromJson(response);
    if (authResponse.isSuccess == true) {
      await authLocalSourceImpl.saveSpecificData(
        value: authResponse.token ?? '',
      );
    }
    return authResponse;
  }

  @override
  Future addPoints({required String action}) async {
    final String token = await authLocalSourceImpl.getData('token');
    String addedPoints = await authRemoteSourceImpl.addPoints(
      action: action,
      token: token,
    );
    print('points_added ----------->from repos $addedPoints');
    return addedPoints;
  }
}
