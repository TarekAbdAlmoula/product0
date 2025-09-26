import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/auth/register/data/model/auth_response.dart';

class AuthState {
  final UiState? uiState;
  final AuthResponse? authResponse;
  AuthState({this.uiState, this.authResponse});

  AuthState copyWith({UiState? uiState, AuthResponse? authResponse}) {
    return AuthState(
      uiState: uiState ?? this.uiState,
      authResponse: authResponse ?? this.authResponse,
    );
  }
}
