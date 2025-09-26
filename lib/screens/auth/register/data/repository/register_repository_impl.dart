import 'package:product0/screens/auth/register/data/datasource/local/register_local_source_impl.dart';
import 'package:product0/screens/auth/register/data/datasource/remote/register_remote_Source_impl.dart';
import 'package:product0/screens/auth/register/data/model/auth_response.dart';
import 'package:product0/screens/auth/register/data/model/user.dart';
import 'package:product0/screens/auth/register/data/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteSourceImpl registerRemoteSourceImpl;
  // final RegisterLocalSourceImpl registerLocalSourceImpl;
  RegisterRepositoryImpl({
    required this.registerRemoteSourceImpl,
    // required this.registerLocalSourceImpl,
  });

  @override
  Future createNewUser({required User user}) async {
    var response = await registerRemoteSourceImpl.createNewUser(user: user);
    final AuthResponse authResponse = AuthResponse.fromJson(response);
    //   if (authResponse.isSuccess == true) {
    //     var loginResponse = await registerRemoteSourceImpl.login(
    //       username: user.firstName,
    //       password: user.password,
    //     );
    //   registerLocalSourceImpl.saveUserData(
    //     token: loginResponse["token"],
    //     username: user.firstName,
    //     password: user.password,
    //   );
    // }

    return authResponse;
  }

  @override
  Future verifyOtp({required String otp, required num userId}) async {
    return registerRemoteSourceImpl.verifyOtp(otp: otp, userId: userId);
  }
}
