import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/about/data/model/about.dart';
import 'package:product0/screens/about/data/repository/about_repository_impl.dart';
import 'package:product0/screens/about/ui/viewmodel/about_state.dart';

class AboutViewmodel extends Cubit<AboutState> {
  final AboutRepositoryImpl aboutRepositoryImpl;
  AboutViewmodel({required this.aboutRepositoryImpl})
    : super(AboutState(uiState: UiState.data)) {
    fetchAboutInfo();
  }
  fetchAboutInfo() async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<About> about = await aboutRepositoryImpl.fetchAboutInfo();
      emit(state.copyWith(uiState: UiState.data, about: about));
    } catch (e) {
      emit(state.copyWith(uiState: UiState.error));
    }
  }
}
