import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/data/model/rating.dart';
import 'package:product0/screens/details/data/repository/details_repository_impl.dart';
import 'package:product0/screens/details/ui/viewmodel/details_state.dart';

class DetailsViewmodel extends Cubit<DetailsState> {
  final DetailsRepositoryImpl detailsRepositoryImpl;
  DetailsViewmodel({required this.detailsRepositoryImpl})
    : super(DetailsState(uiState: UiState.data));

  Future sendRating(num rating, int workshopId, {String? comment}) async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      Rating ratingModel = await detailsRepositoryImpl.sendRating(
        rating,
        workshopId,
        comment: comment,
      );
      emit(state.copyWith(uiState: UiState.data, ratingModel: ratingModel));
    } catch (e) {
      print(e.toString());
    }
  }
}
