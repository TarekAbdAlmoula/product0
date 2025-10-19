import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/data/model/rating.dart';

class DetailsState {
  final UiState? uiState;
  Rating? ratingModel;
  DetailsState({this.uiState, this.ratingModel});

  DetailsState copyWith({UiState? uiState, Rating? ratingModel}) {
    return DetailsState(
      uiState: uiState ?? this.uiState,
      ratingModel: ratingModel ?? this.ratingModel,
    );
  }
}
