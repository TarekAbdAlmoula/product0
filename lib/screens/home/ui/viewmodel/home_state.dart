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
  final bool hasSearched; // 👈 متغير جديد

  final List<Workshop> searchedWorkshops;

  final String? userName;
  final int? userPoints;
  HomeState({
    this.uiState,
    this.prod = const [],
    this.categories = const [],
    this.prodByCategory = const [],
    this.adds = const [],
    this.currentBannerIndex = 0,
    this.featuredWorkshop = const [],
    this.topRatedWorkshop = const [],
    this.searchedWorkshops = const [],
    this.userName,
    this.userPoints,
    this.hasSearched = false, // 👈 القيمة الافتراضية
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
    List<Workshop>? searchedWorkshops,
    bool? hasSearched,

    String? userName,
    int? userPoints,
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
      searchedWorkshops: searchedWorkshops ?? this.searchedWorkshops,
      userName: userName ?? this.userName,
      userPoints: userPoints ?? this.userPoints,
      hasSearched: hasSearched ?? this.hasSearched, // 👈
    );
  }
}
