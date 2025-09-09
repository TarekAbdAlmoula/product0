import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/home/data/model/prod.dart';

class ProductsState {
  final UiState? uiState;
  final List<Prod> prodByCategory;
  ProductsState({this.uiState, this.prodByCategory = const []});

  ProductsState copyWith({UiState? uiState, List<Prod>? prodByCategory}) {
    return ProductsState(
      uiState: uiState ?? this.uiState,
      prodByCategory: prodByCategory ?? this.prodByCategory,
    );
  }
}
