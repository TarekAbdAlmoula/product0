import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/home/data/model/categories.dart';
import 'package:product0/screens/home/data/model/prod.dart';
import 'package:product0/screens/home/data/resposirory/home_repository_impl.dart';
import 'package:product0/screens/home/ui/viewmode/home_State.dart';

class HomeViewModel extends Cubit<HomeState> {
  final HomeRepositoryImpl homeRepositoryImpl;
  HomeViewModel({required this.homeRepositoryImpl})
    : super(HomeState(uiState: UiState.data)) {
    init();
  }

  Future init() async {
    await Future.wait([getProducts(), getCategories()]);
  }

  Future getProducts() async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Prod> prod = await homeRepositoryImpl.getProducts();
      emit(state.copyWith(uiState: UiState.data, prod: prod));
    } catch (e) {}
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
      List<Prod> prod = await homeRepositoryImpl.getProductsByCategory(id);
      print(prod);

      emit(state.copyWith(uiState: UiState.data, prodByCategory: prod));
    } catch (e) {}
  }
}
