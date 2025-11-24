import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/premieum/data/model/premieum.dart';
import 'package:product0/screens/premieum/data/repository/premieum_repository_impl.dart';
import 'package:product0/screens/premieum/ui/viewmodel/premieum_state.dart';

class PremieumViewmodel extends Cubit<PremieumState> {
  final PremieumRepositoryImpl premieumRepositoryImpl;
  PremieumViewmodel({required this.premieumRepositoryImpl})
    : super(PremieumState(uiState: UiState.data)) {
    init();
  }

  Future init() async {
    await Future.wait([getPlans()]);
  }

  Future getPlans() async {
    if (isClosed) return;
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Premieum> premieum = await premieumRepositoryImpl.getPlans();
      if (!isClosed) {
        emit(state.copyWith(uiState: UiState.data, premieum: premieum));
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

  Future pickImages() async {
    List<XFile>? images = await premieumRepositoryImpl.pickImages();
    emit(state.copyWith(uiState: UiState.data, images: images));
  }

  Future uploadImages({
    required List<XFile>? images,
    required String token,
    required String productName,
    required String productDescription,
    required String location,
    required String phoneNumber,
    required String price,
  }) async {
    if (isClosed) return;
    emit(state.copyWith(uiState: UiState.loading));
    try {
      bool isSuccess = await premieumRepositoryImpl.uploadImages(
        images: images,
        token: token,
        productName: productName,
        productDescription: productDescription,
        location: location,
        phoneNumber: phoneNumber,
        price: price,
      );
      if (!isClosed) {
        emit(state.copyWith(uiState: UiState.data, isFormSent: isSuccess));
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
}
