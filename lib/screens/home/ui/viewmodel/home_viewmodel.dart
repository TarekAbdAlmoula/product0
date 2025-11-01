import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/ui/viewmodel/home_State.dart';

class HomeViewModel extends Cubit<HomeState> {
  final HomeRepositoryImpl homeRepositoryImpl;

  HomeViewModel({required this.homeRepositoryImpl})
    : super(HomeState(uiState: UiState.loading)) {
    init();
  }

  Future init() async {
    emit(state.copyWith(uiState: UiState.loading));

    try {
      final categories = await homeRepositoryImpl.getCategories();
      final ads = await homeRepositoryImpl.getAdds();
      final featuredWorkshop = await homeRepositoryImpl.getFeaturedWorkshops();
      final topRatedWorkshop = await homeRepositoryImpl.getTopRatedWorkshop();
      final pointMessage = await homeRepositoryImpl.addPoints(
        action: 'daily_login',
      );
      final userPoints = await homeRepositoryImpl.getUserPoints();
      final userName = await homeRepositoryImpl.getLocalData(key: 'username');

      final pointsExpl = await homeRepositoryImpl.getPointsExpl();

      emit(
        state.copyWith(
          uiState: UiState.data,
          categories: categories,
          ads: ads,
          featuredWorkshop: featuredWorkshop,
          topRatedWorkshop: topRatedWorkshop,
          userPoints: userPoints,
          userName: userName,
          pointMessage: pointMessage,
          pointsExpl: pointsExpl,
        ),
      );
    } catch (e) {
      final errorMessage = e is String
          ? e
          : "فشل الاتصال بالخادم. تحقق من الإنترنت وحاول مرة أخرى";
      emit(state.copyWith(uiState: UiState.error, erroemessage: errorMessage));
    }
  }

  //   Future getCategories() async {
  //     try {
  //       List<Categories> categories = await homeRepositoryImpl.getCategories();
  //       // emit(state.copyWith(uiState: UiState.data, categories: categories));
  //     } catch (e) {
  //       final errorMessage = e is String
  //           ? e
  //           : e.toString().replaceAll('Exception: ', '');

  //       // emit(state.copyWith(uiState: UiState.error, erroemessage: errorMessage));
  //     }
  //   }

  //   Future getAdds() async {
  //     try {
  //       var adds = await homeRepositoryImpl.getAdds();
  //       // emit(state.copyWith(uiState: UiState.data, adds: adds));
  //     } catch (e) {}
  //   }

  //   Future getFeaturedWorkshops() async {
  //     try {
  //       List<Workshop> featuredWorkshop = await homeRepositoryImpl
  //           .getFeaturedWorkshops();
  //       // emit(
  //       //   state.copyWith(
  //       //     uiState: UiState.data,
  //       //     featuredWorkshop: featuredWorkshop,
  //       //   ),
  //       // );
  //     } catch (e) {}
  //   }

  //   Future getTopRatedWorkshop() async {
  //     try {
  //       List<Workshop> topRatedWorkshop = await homeRepositoryImpl
  //           .getTopRatedWorkshop();
  //       // emit(
  //       //   state.copyWith(
  //       //     uiState: UiState.data,
  //       //     topRatedWorkshop: topRatedWorkshop,
  //       //   ),
  //       // );
  //     } catch (e) {}
  //   }

  //   Future getUserName() async {
  //     try {
  //       String userNamae = await homeRepositoryImpl.getLocalData(key: 'username');
  //       // emit(state.copyWith(uiState: UiState.data, userName: userNamae));
  //     } catch (e) {}
  //   }

  //   Future getUserPoints() async {
  //     try {
  //       int userPoints = await homeRepositoryImpl.getUserPoints();

  //       // emit(state.copyWith(uiState: UiState.data, userPoints: userPoints));
  //     } catch (e) {}
  //   }

  //   Future addPoints() async {
  //     await homeRepositoryImpl.addPoints(action: 'daily_login');
  //     await getUserPoints();
  //   }

  Future searchWorkshops({required String query}) async {
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
