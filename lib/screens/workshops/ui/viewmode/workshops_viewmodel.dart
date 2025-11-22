import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/models/workshop.dart';
import 'package:product0/screens/workshops/data/repository/workshops_repository_impl.dart';
import 'package:product0/screens/workshops/ui/viewmode/workshops_state.dart';

class ProductsViewmodel extends Cubit<ProductsState> {
  final WorkshopsRepositoryImpl productsRepositoryImpl;
  ProductsViewmodel({required this.productsRepositoryImpl})
    : super(ProductsState(uiState: UiState.data)) {
    init();
  }
  void init() async {
    getToken();
  }

  Future getProductsByCategory({required int id}) async {
    if (isClosed) return;
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Workshop> workshop = await productsRepositoryImpl
          .getProductsByCategory(id);

      if (!isClosed) {
        emit(state.copyWith(uiState: UiState.data, workshop: workshop));
      }
    } catch (e) {
      final errorMessage = e is String
          ? e
          : "فشل الاتصال بالخادم. تحقق من الإنترنت وحاول مرة أخرى.";
      if (!isClosed) {
        emit(
          state.copyWith(uiState: UiState.error, erroemessage: errorMessage),
        );
      }
    }
  }

  Future searchedWorkshop({required String query, required int id}) async {
    if (isClosed) return;

    emit(state.copyWith(uiState: UiState.loading));

    try {
      List<Workshop> searchedWorkshop = await productsRepositoryImpl
          .searchedWorkshop(query: query, id: id);

      if (!isClosed) {
        emit(
          state.copyWith(
            uiState: UiState.data,
            searchedWorkshop: searchedWorkshop,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(uiState: UiState.error, erroemessage: e.toString()),
        );
      }
    }
  }

  Future refreshWorkShop() async {
    emit(
      state.copyWith(
        uiState: UiState.data,
        workshop: state.workshop,
        searchedWorkshop: [],
      ),
    );
  }

  Future getToken() async {
    final FlutterSecureStorage storage = const FlutterSecureStorage();
    String token = await storage.read(key: 'token') ?? '';
    if (!isClosed) {
      emit(state.copyWith(token: token, uiState: UiState.loading));
    }
  }
}
