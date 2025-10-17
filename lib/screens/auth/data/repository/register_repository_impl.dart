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
    var response = await authRemoteSourceImpl.createNewUser(user: user);
    final AuthResponse authResponse = AuthResponse.fromJson(response);
    if (authResponse.isSuccess == true) {
      authLocalSourceImpl.saveUserData(
        username: user.firstName ?? '',
        password: user.password ?? '',
        userId: authResponse.userId,
        email: user.email ?? '',
        accountType: user.userType ?? '',
      );
    }

    return authResponse;
  }

  @override
  Future verifyOtp({required String otp}) async {
    String userId = await authLocalSourceImpl.getData('userId');
    String token = await authRemoteSourceImpl.verifyOtp(
      otp: otp,
      userId: userId,
    );
    await authLocalSourceImpl.saveSpecificData(value: token);
    bool status;
    if (token.isNotEmpty) {
      status = true;
    } else {
      status = false;
    }

    return status;
  }

  @override
  Future login({required String email, required String password}) async {
    final User user = await authRemoteSourceImpl.login(
      email: email,
      password: password,
    );
    if (user.isLoggedIn) {
      await authLocalSourceImpl.saveUserData(
        username: user.firstName ?? '',
        password: user.password ?? '',
        userId: user.userId ?? 0,
        email: user.email ?? '',
        accountType: user.userType ?? '',
        token: user.token,
      );
    }
    return user.isLoggedIn;
  }

  @override
  Future addPoints({required String action}) async {
    final String token = await authLocalSourceImpl.getData('token');
    return await authRemoteSourceImpl.addPoints(action: action, token: token);
  }
}
