import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/auth/data/model/auth_response.dart';

class AuthState {
  final UiState? uiState;
  final AuthResponse? authResponse;
  final bool isOtpVerified;
  final bool isLoggedIn;
  final String pointsMessage;
  final String? erroemessage;

  AuthState({
    this.uiState,
    this.authResponse,
    this.isOtpVerified = false,
    this.isLoggedIn = false,
    this.pointsMessage = '',
    this.erroemessage,
  });

  AuthState copyWith({
    UiState? uiState,
    AuthResponse? authResponse,
    bool? isOtpVerified,
    bool? isLoggedIn,
    String? addedPoints,
    String? erroemessage,
  }) {
    return AuthState(
      uiState: uiState ?? this.uiState,
      authResponse: authResponse ?? this.authResponse,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      pointsMessage: addedPoints ?? this.pointsMessage,
      erroemessage: erroemessage ?? this.erroemessage,
    );
  }
}
