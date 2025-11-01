import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/workshop.dart';

class ProductsState {
  final UiState? uiState;
  final List<Workshop> workshop;
  final String? erroemessage;

  ProductsState({this.uiState, this.workshop = const [], this.erroemessage});

  ProductsState copyWith({
    UiState? uiState,
    List<Workshop>? workshop,
    String? erroemessage,
  }) {
    return ProductsState(
      uiState: uiState ?? this.uiState,
      workshop: workshop ?? this.workshop,
      erroemessage: erroemessage,
    );
  }
}
