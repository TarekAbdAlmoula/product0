import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/categories.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/home/data/model/prod.dart';

class HomeState {
  final UiState? uiState;
  final List<Prod> prod;
  final List<Categories> categories;
  final List<Prod> prodByCategory;
  final List<String> adds;
  final int currentBannerIndex;
  final List<Workshop> featuredWorkshop;
  final List<Workshop> topRatedWorkshop;
  HomeState({
    this.uiState,
    this.prod = const [],
    this.categories = const [],
    this.prodByCategory = const [],
    this.adds = const [],
    this.currentBannerIndex = 0,
    this.featuredWorkshop = const [],
    this.topRatedWorkshop = const [],
  });

  HomeState copyWith({
    UiState? uiState,
    List<Prod>? prod,
    List<Categories>? categories,
    List<Prod>? prodByCategory,
    List<String>? adds,
    int? currentBannerIndex,
    List<Workshop>? featuredWorkshop,
    List<Workshop>? topRatedWorkshop,
  }) {
    return HomeState(
      uiState: uiState ?? this.uiState,
      prod: prod ?? this.prod,
      categories: categories ?? this.categories,
      prodByCategory: prodByCategory ?? this.prodByCategory,
      adds: adds ?? this.adds,
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
      featuredWorkshop: featuredWorkshop ?? this.featuredWorkshop,
      topRatedWorkshop: topRatedWorkshop ?? this.topRatedWorkshop,
    );
  }
}
