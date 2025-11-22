import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/workshop.dart';

class ProductsState {
  final UiState? uiState;
  final List<Workshop> workshop;
  final String? erroemessage;
  final List<Workshop>? searchedWorkshop;
  final String token;

  ProductsState({
    this.uiState,
    this.workshop = const [],
    this.erroemessage,
    this.searchedWorkshop = const [],
    this.token = '',
  });

  ProductsState copyWith({
    UiState? uiState,
    List<Workshop>? workshop,
    List<Workshop>? searchedWorkshop,
    String? erroemessage,
    String? token,
  }) {
    return ProductsState(
      uiState: uiState ?? this.uiState,
      workshop: workshop ?? this.workshop,
      erroemessage: erroemessage ?? this.erroemessage,
      searchedWorkshop: searchedWorkshop ?? this.searchedWorkshop,
      token: token ?? this.token,
    );
  }
}
