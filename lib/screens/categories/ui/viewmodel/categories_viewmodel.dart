import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/categories.dart';
import 'package:product0/screens/categories/data/repository/categories_repository.dart';
import 'package:product0/screens/categories/ui/viewmodel/categories_state.dart';

class CategoriesViewmodel extends Cubit<CategoriesState> {
  final CategoriesRepository categoriesRepository;
  CategoriesViewmodel({required this.categoriesRepository})
    : super(CategoriesState(uiState: UiState.data));
  Future getCategoriesById(int id) async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Categories> categories = [];
      categories = await categoriesRepository.getCategoriesById(id);
      emit(state.copyWith(uiState: UiState.data, categories: categories));
    } catch (e) {
      final errorMessage = e is String
          ? e
          : "فشل الاتصال بالخادم. تحقق من الإنترنت وحاول مرة أخرى.";
      emit(state.copyWith(uiState: UiState.error, erroemessage: errorMessage));
    }
  }
}
