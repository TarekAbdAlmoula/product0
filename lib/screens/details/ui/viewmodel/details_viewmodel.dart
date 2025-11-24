import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/details/data/model/rating.dart';
import 'package:product0/screens/details/data/repository/details_repository_impl.dart';
import 'package:product0/screens/details/ui/viewmodel/details_state.dart';

class DetailsViewmodel extends Cubit<DetailsState> {
  final DetailsRepositoryImpl detailsRepositoryImpl;
  DetailsViewmodel({required this.detailsRepositoryImpl})
    : super(DetailsState(uiState: UiState.data)) {
    init();
  }
  void init() async {
    await getToken();
  }

  Future sendRating(num rating, int workshopId, {String? comment}) async {
    if (isClosed) return;

    emit(state.copyWith(uiState: UiState.loading));
    try {
      Rating ratingModel = await detailsRepositoryImpl.sendRating(
        rating,
        workshopId,
        comment: comment,
      );
      if (!isClosed) {
        emit(state.copyWith(uiState: UiState.data, ratingModel: ratingModel));
      }
    } catch (e) {
      final errorMessage = e is String
          ? e
          : "فشل الاتصال بالخادم. تحقق من الإنترنت وحاول مرة أخرى.";
      if (!isClosed) {
        emit(
          state.copyWith(uiState: UiState.error, erroemessage: errorMessage),
        );
      }
    }
  }

  Future getToken() async {
    final FlutterSecureStorage storage = const FlutterSecureStorage();
    String token = await storage.read(key: 'token') ?? '';
    if (!isClosed) {
      emit(state.copyWith(token: token, uiState: UiState.data));
    }
  }

  Future callService({required String workshopId}) async {
    try {
      await detailsRepositoryImpl.callService(workshopId: workshopId);
    } on Exception catch (e) {
      // TODO
    }
  }
}
