import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/categories.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/ui/viewmode/home_State.dart';

class HomeViewModel extends Cubit<HomeState> {
  final HomeRepositoryImpl homeRepositoryImpl;
  Timer? _bannerTimer;

  HomeViewModel({required this.homeRepositoryImpl})
    : super(HomeState(uiState: UiState.data)) {
    init();
  }

  Future init() async {
    await Future.wait([getAdds(), getCategories()]);
  }

  Future getCategories() async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Categories> categories = await homeRepositoryImpl.getCategories();
      emit(state.copyWith(uiState: UiState.data, categories: categories));
    } catch (e) {}
  }

  Future getProductsByCategory({required int id}) async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      // List<Prod> prod = await homeRepositoryImpl.getProductsByCategory(id);
      // print(prod);

      // emit(state.copyWith(uiState: UiState.data, prodByCategory: prod));
    } catch (e) {}
  }

  Future getAdds() async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      var adds = await homeRepositoryImpl.getAdds();
      emit(state.copyWith(uiState: UiState.data, adds: adds));
      startBanerAutoScroll();
    } catch (e) {}
  }

  void startBanerAutoScroll() {
    if (state.adds.isEmpty) return;
    _bannerTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      emit(
        state.copyWith(
          uiState: UiState.data,
          currentBannerIndex:
              (state.currentBannerIndex + 1) % state.adds.length,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _bannerTimer?.cancel(); // <-- نوقف التايمر
    return super.close();
  }
}
