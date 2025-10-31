import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/about/data/model/about.dart';

class AboutState {
  final UiState uiState;
  final List<About> about;
  final String? erroemessage;

  AboutState({required this.uiState, this.about = const [], this.erroemessage});
  AboutState copyWith({
    UiState? uiState,
    List<About>? about,
    String? erroemessage,
  }) {
    return AboutState(
      uiState: uiState ?? this.uiState,
      about: about ?? this.about,
      erroemessage: erroemessage ?? this.erroemessage,
    );
  }
}
