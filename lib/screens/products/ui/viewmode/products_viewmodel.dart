import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/home/data/model/prod.dart';
import 'package:product0/screens/products/data/repository/products_repository_impl.dart';
import 'package:product0/screens/products/ui/viewmode/products_state.dart';

class ProductsViewmodel extends Cubit<ProductsState> {
  final ProductsRepositoryImpl productsRepositoryImpl;
  ProductsViewmodel({required this.productsRepositoryImpl})
    : super(ProductsState(uiState: UiState.data));

  Future getProductsByCategory({required int id}) async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Prod> prod = await productsRepositoryImpl.getProductsByCategory(id);
      print(prod);

      emit(state.copyWith(uiState: UiState.data, prodByCategory: prod));
    } catch (e) {}
  }
}
