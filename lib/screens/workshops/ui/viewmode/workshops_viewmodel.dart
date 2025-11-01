import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/workshops/data/repository/workshops_repository_impl.dart';
import 'package:product0/screens/workshops/ui/viewmode/workshops_state.dart';

class ProductsViewmodel extends Cubit<ProductsState> {
  final WorkshopsRepositoryImpl productsRepositoryImpl;
  ProductsViewmodel({required this.productsRepositoryImpl})
    : super(ProductsState(uiState: UiState.data));

  Future getProductsByCategory({required int id}) async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Workshop> workshop = await productsRepositoryImpl
          .getProductsByCategory(id);

      emit(state.copyWith(uiState: UiState.data, workshop: workshop));
    } catch (e) {
      final errorMessage = e is String
          ? e
          : "فشل الاتصال بالخادم. تحقق من الإنترنت وحاول مرة أخرى.";
      emit(state.copyWith(uiState: UiState.error, erroemessage: errorMessage));
    }
  }
}
