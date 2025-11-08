import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/data/model/rating.dart';

class DetailsState {
  final UiState? uiState;
  final Rating? ratingModel;
  final String? erroemessage;
  final String? token;
  final String? accountType;

  DetailsState({
    this.uiState,
    this.ratingModel,
    this.erroemessage,
    this.token,
    this.accountType,
  });

  DetailsState copyWith({
    UiState? uiState,
    Rating? ratingModel,
    String? erroemessage,
    String? token,
    String? accountType,
  }) {
    return DetailsState(
      uiState: uiState ?? this.uiState,
      ratingModel: ratingModel ?? this.ratingModel,
      erroemessage: erroemessage ?? this.erroemessage,
      token: token ?? this.token,
      accountType: accountType ?? this.accountType,
    );
  }
}
