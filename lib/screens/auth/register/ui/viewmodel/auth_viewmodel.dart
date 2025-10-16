import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/auth/data/model/user.dart';
import 'package:product0/screens/auth/data/repository/register_repository_impl.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_state.dart';

class AuthViewmodel extends Cubit<AuthState> {
  final AuthRepositoryImpl authRepositoryImp;
  AuthViewmodel({required this.authRepositoryImp})
    : super(AuthState(uiState: UiState.data));

  Future createNewUser(User user) async {
    try {
      // emit(state.copyWith(uiState: UiState.loading));

      final authResponse = await authRepositoryImp.createNewUser(user: user);

      if (authResponse.isSuccess == true) {
        emit(state.copyWith(uiState: UiState.data, authResponse: authResponse));
      }
    } catch (e) {
      emit(state.copyWith(uiState: UiState.error));
    }
  }

  Future verifyOtp({required String otp, required num userId}) async {
    // emit(state.copyWith(uiState: UiState.loading));
    try {
      bool isOtpVerified = await authRepositoryImp.verifyOtp(otp: otp);
      if (isOtpVerified) {
        await authRepositoryImp.addPoints(action: 'first_signup');
      }
      emit(state.copyWith(uiState: UiState.data, isOtpVerified: isOtpVerified));
    } catch (e) {}
  }

  Future login(String email, String password) async {
    try {
      bool isLoggedIn = await authRepositoryImp.login(
        email: email,
        password: password,
      );
      emit(state.copyWith(uiState: UiState.data, isLoggedIn: isLoggedIn));
    } catch (e) {}
  }
}
