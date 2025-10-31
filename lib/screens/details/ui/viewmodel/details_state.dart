import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/data/model/rating.dart';

class DetailsState {
  final UiState? uiState;
  Rating? ratingModel;
  final String? erroemessage;

  DetailsState({this.uiState, this.ratingModel, this.erroemessage});

  DetailsState copyWith({
    UiState? uiState,
    Rating? ratingModel,
    String? erroemessage,
  }) {
    return DetailsState(
      uiState: uiState ?? this.uiState,
      ratingModel: ratingModel ?? this.ratingModel,
      erroemessage: erroemessage ?? this.erroemessage,
    );
  }
}
