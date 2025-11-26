import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/ui/viewmodel/home_State.dart';

class HomeViewModel extends Cubit<HomeState> {
  final HomeRepositoryImpl homeRepositoryImpl;

  HomeViewModel({required this.homeRepositoryImpl, bool runInit = true})
    : super(HomeState(uiState: UiState.loading)) {
    if (runInit) {
      init();
    }
  }

  Future init() async {
    if (isClosed) return;

    emit(state.copyWith(uiState: UiState.loading));

    try {
      final token = await homeRepositoryImpl.getLocalData(key: 'token');
      final accountType = await homeRepositoryImpl.getLocalData(
        key: 'accountType',
      );
      final isGuest = token == null || token.isEmpty;
      final categories = await homeRepositoryImpl.getCategories();
      final ads = await homeRepositoryImpl.getAdds();
      final featuredWorkshop = await homeRepositoryImpl.getFeaturedWorkshops();
      final topRatedWorkshop = await homeRepositoryImpl.getTopRatedWorkshop();
      final accreditedWorkshop = await homeRepositoryImpl
          .getAccreditedWorkshop();
      final pointsExpl = await homeRepositoryImpl.getPointsExpl();
      String? pointMessage;
      int? userPoints;
      String? userName;
      bool? isServiceProvider;
      if (!isGuest) {
        userName = await homeRepositoryImpl.getLocalData(key: 'username');
        if (accountType != 'مقدم خدمة') {
          pointMessage = await homeRepositoryImpl.addPoints(
            action: 'daily_login',
          );
          userPoints = await homeRepositoryImpl.getUserPoints();
          isServiceProvider = false;
        }
      }

      if (!isClosed) {
        emit(
          state.copyWith(
            uiState: UiState.data,
            categories: categories,
            ads: ads,
            featuredWorkshop: featuredWorkshop,
            topRatedWorkshop: topRatedWorkshop,
            accreditedWorkshop: accreditedWorkshop,
            userPoints: userPoints,
            userName: userName,
            pointMessage: pointMessage,
            pointsExpl: pointsExpl,
            isServiceProvider: isServiceProvider,
            token: token,
          ),
        );
      }
    } catch (e) {
      final errorMessage = e is String ? e : "التطبيق في حالة الصيانة ";

      if (!isClosed) {
        emit(
          state.copyWith(uiState: UiState.error, erroemessage: errorMessage),
        );
      }
    }
  }

  Future searchWorkshops({required String query}) async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Workshop>? searchedWorkshops;
      searchedWorkshops = await homeRepositoryImpl.searchWorkshops(
        query: query,
      );
      emit(
        state.copyWith(
          uiState: UiState.data,
          searchedWorkshops: searchedWorkshops,
          hasSearched: true,
        ),
      );
    } catch (e) {
      final errorMessage = e is String
          ? e
          : "فشل الاتصال بالخادم. تحقق من الإنترنت وحاول مرة أخرى.";
      emit(state.copyWith(uiState: UiState.error, erroemessage: errorMessage));
    }
  }
}
