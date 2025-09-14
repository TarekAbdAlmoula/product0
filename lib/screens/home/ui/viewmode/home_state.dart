import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/categories.dart';
import 'package:product0/screens/home/data/model/prod.dart';

class HomeState {
  final UiState? uiState;
  final List<Prod> prod;
  final List<Categories> categories;
  final List<Prod> prodByCategory;
  final List<String> adds;
  final int currentBannerIndex;
  HomeState({
    this.uiState,
    this.prod = const [],
    this.categories = const [],
    this.prodByCategory = const [],
    this.adds = const [],
    this.currentBannerIndex = 0,
  });

  HomeState copyWith({
    UiState? uiState,
    List<Prod>? prod,
    List<Categories>? categories,
    List<Prod>? prodByCategory,
    List<String>? adds,
    int? currentBannerIndex,
  }) {
    return HomeState(
      uiState: uiState ?? this.uiState,
      prod: prod ?? this.prod,
      categories: categories ?? this.categories,
      prodByCategory: prodByCategory ?? this.prodByCategory,
      adds: adds ?? this.adds,
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
    );
  }
}
