import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/auth/data/model/auth_response.dart';
import 'package:product0/screens/auth/data/model/user.dart';
import 'package:product0/screens/auth/data/repository/register_repository_impl.dart';
import 'package:product0/screens/auth/register/ui/viewmodel/auth_state.dart';

class AuthViewmodel extends Cubit<AuthState> {
  final AuthRepositoryImpl authRepositoryImp;
  AuthViewmodel({required this.authRepositoryImp})
    : super(AuthState(uiState: UiState.data));

  Future createNewUser(User user) async {
    try {
      final AuthResponse authResponse = await authRepositoryImp.createNewUser(
        user: user,
      );
      emit(state.copyWith(uiState: UiState.data, authResponse: authResponse));
    } catch (e) {
      final errorMessage = e is String
          ? e
          : e.toString().replaceAll('Exception: ', '');

      emit(state.copyWith(uiState: UiState.error, erroemessage: errorMessage));
    }
  }

  Future verifyOtp({required String otp, required num userId}) async {
    try {
      final AuthResponse authResponse = await authRepositoryImp.verifyOtp(
        otp: otp,
      );
      if (authResponse.isSuccess == true) {
        print('inside if from otp');
        String addedPoints = await authRepositoryImp.addPoints(
          action: 'first_signup',
        );
        emit(
          state.copyWith(
            uiState: UiState.data,
            authResponse: authResponse,
            addedPoints: addedPoints,
          ),
        );
      } else if (authResponse.isSuccess == false) {
        print('inside else if from otp');

        emit(state.copyWith(uiState: UiState.data, authResponse: authResponse));
      }
    } catch (e) {}
  }

  Future login(String email, String password) async {
    try {
      dynamic isLoggedIn = await authRepositoryImp.login(
        email: email,
        password: password,
      );
      if (isLoggedIn == true) {
        emit(state.copyWith(uiState: UiState.data, isLoggedIn: isLoggedIn));
      } else if (isLoggedIn is AuthResponse) {
        emit(state.copyWith(uiState: UiState.data, authResponse: isLoggedIn));
      }
    } catch (e) {
      final errorMessage = e is String
          ? e
          : e.toString().replaceAll('Exception: ', '');

      emit(state.copyWith(uiState: UiState.error, erroemessage: errorMessage));
    }
  }
}
