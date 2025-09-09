import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/home/data/model/categories.dart';
import 'package:product0/screens/home/data/model/prod.dart';

class HomeState {
  final UiState? uiState;
  final List<Prod> prod;
  final List<Categories> categories;
  final List<Prod> prodByCategory;
  HomeState({
    this.uiState,
    this.prod = const [],
    this.categories = const [],
    this.prodByCategory = const [],
  });

  HomeState copyWith({
    UiState? uiState,
    List<Prod>? prod,
    List<Categories>? categories,
    List<Prod>? prodByCategory,
  }) {
    return HomeState(
      uiState: uiState ?? this.uiState,
      prod: prod ?? this.prod,
      categories: categories ?? this.categories,
      prodByCategory: prodByCategory ?? this.prodByCategory,
    );
  }
}
