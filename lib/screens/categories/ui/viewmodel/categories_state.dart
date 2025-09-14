import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/categories.dart';

class CategoriesState {
  final UiState uiState;
  final List<Categories> categories;
  CategoriesState({required this.uiState, this.categories = const []});
  CategoriesState copyWith({UiState? uiState, List<Categories>? categories}) {
    return CategoriesState(
      uiState: uiState ?? this.uiState,
      categories: categories ?? this.categories,
    );
  }
}
