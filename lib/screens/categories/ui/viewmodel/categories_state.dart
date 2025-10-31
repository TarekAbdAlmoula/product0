import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/categories.dart';

class CategoriesState {
  final UiState uiState;
  final List<Categories> categories;
  final String? erroemessage;

  CategoriesState({
    required this.uiState,
    this.categories = const [],
    this.erroemessage,
  });
  CategoriesState copyWith({
    UiState? uiState,
    List<Categories>? categories,
    String? erroemessage,
  }) {
    return CategoriesState(
      uiState: uiState ?? this.uiState,
      categories: categories ?? this.categories,
      erroemessage: erroemessage ?? this.erroemessage,
    );
  }
}
