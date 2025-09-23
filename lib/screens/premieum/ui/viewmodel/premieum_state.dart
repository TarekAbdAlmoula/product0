import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/premieum/data/model/premieum.dart';

class PremieumState {
  final UiState uiState;
  final List<Premieum> premieum;
  PremieumState({this.uiState = UiState.loading, this.premieum = const []});

  PremieumState copyWith({UiState? uiState, List<Premieum>? premieum}) {
    return PremieumState(
      uiState: uiState ?? this.uiState,
      premieum: premieum ?? this.premieum,
    );
  }
}
