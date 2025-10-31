import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/premieum/data/model/premieum.dart';

class PremieumState {
  final UiState uiState;
  final List<Premieum> premieum;
  final String? erroemessage;

  PremieumState({
    this.uiState = UiState.loading,
    this.premieum = const [],
    this.erroemessage,
  });

  PremieumState copyWith({
    UiState? uiState,
    List<Premieum>? premieum,
    String? erroemessage,
  }) {
    return PremieumState(
      erroemessage: erroemessage ?? this.erroemessage,
      uiState: uiState ?? this.uiState,
      premieum: premieum ?? this.premieum,
    );
  }
}
