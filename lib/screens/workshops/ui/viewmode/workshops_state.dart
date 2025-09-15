import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/workshops/data/model/workshop.dart';

class ProductsState {
  final UiState? uiState;
  final List<Workshop> workshop;
  ProductsState({this.uiState, this.workshop = const []});

  ProductsState copyWith({UiState? uiState, List<Workshop>? workshop}) {
    return ProductsState(
      uiState: uiState ?? this.uiState,
      workshop: workshop ?? this.workshop,
    );
  }
}
