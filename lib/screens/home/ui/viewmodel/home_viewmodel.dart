import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/categories.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/ui/viewmodel/home_State.dart';

class HomeViewModel extends Cubit<HomeState> {
  final HomeRepositoryImpl homeRepositoryImpl;
  Timer? _bannerTimer;

  HomeViewModel({required this.homeRepositoryImpl})
    : super(HomeState(uiState: UiState.data)) {
    init();
  }

  Future init() async {
    await Future.wait([
      getFeaturedWorkshops(),
      getAdds(),
      getCategories(),
      getTopRatedWorkshop(),
      addPoints(),
      getUserName(),
    ]);
  }

  Future getCategories() async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Categories> categories = await homeRepositoryImpl.getCategories();
      emit(state.copyWith(uiState: UiState.data, categories: categories));
    } catch (e) {}
  }

  Future getAdds() async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      var adds = await homeRepositoryImpl.getAdds();
      emit(state.copyWith(uiState: UiState.data, adds: adds));
      // startBanerAutoScroll();
    } catch (e) {}
  }

  // void startBanerAutoScroll() {
  //   if (state.adds.isEmpty) return;
  //   _bannerTimer = Timer.periodic(Duration(seconds: 3), (timer) {
  //     emit(
  //       state.copyWith(
  //         uiState: UiState.data,
  //         currentBannerIndex:
  //             (state.currentBannerIndex + 1) % state.adds.length,
  //       ),
  //     );
  //   });
  // }

  Future getFeaturedWorkshops() async {
    emit(state.copyWith(uiState: UiState.loading));

    try {
      List<Workshop> featuredWorkshop = await homeRepositoryImpl
          .getFeaturedWorkshops();
      emit(
        state.copyWith(
          uiState: UiState.data,
          featuredWorkshop: featuredWorkshop,
        ),
      );
    } catch (e) {}
  }

  Future getTopRatedWorkshop() async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Workshop> topRatedWorkshop = await homeRepositoryImpl
          .getTopRatedWorkshop();
      emit(
        state.copyWith(
          uiState: UiState.data,
          topRatedWorkshop: topRatedWorkshop,
        ),
      );
    } catch (e) {}
  }

  Future getUserName() async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      String userNamae = await homeRepositoryImpl.getLocalData(key: 'username');
      emit(state.copyWith(uiState: UiState.data, userName: userNamae));
    } catch (e) {}
  }

  Future getUserPoints() async {
    try {
      int userPoints = await homeRepositoryImpl.getUserPoints();

      emit(state.copyWith(uiState: UiState.data, userPoints: userPoints));
    } catch (e) {}
  }

  Future addPoints() async {
    await homeRepositoryImpl.addPoints(action: 'daily_login');
    await getUserPoints();
  }

  Future searchWorkshops({required String query}) async {
    try {
      emit(state.copyWith(uiState: UiState.loading));
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
    } catch (e) {}
  }

  // Future searchWorkshops() {}
  @override
  Future<void> close() {
    _bannerTimer?.cancel();
    return super.close();
  }
}
