import 'package:product0/core/utils/ui_state.dart';

class DetailsState {
  final UiState? uiState;
  final num? rating;
  DetailsState({this.uiState, this.rating});

  DetailsState copyWith({UiState? uiState, num? rating}) {
    return DetailsState(
      uiState: uiState ?? this.uiState,
      rating: rating ?? this.rating,
    );
  }
}
