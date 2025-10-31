import 'package:flutter_bloc/flutter_bloc.dart';
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
    print('--------------------------------------');
    await Future.wait([getPlans()]);
  }

  Future getPlans() async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Premieum> premieum = await premieumRepositoryImpl.getPlans();
      emit(state.copyWith(uiState: UiState.data, premieum: premieum));
    } catch (e) {
      final errorMessage = e is String
          ? e
          : "فشل الاتصال بالخادم. تحقق من الإنترنت وحاول مرة أخرى.";
      emit(state.copyWith(uiState: UiState.error, erroemessage: errorMessage));
    }
  }
}
