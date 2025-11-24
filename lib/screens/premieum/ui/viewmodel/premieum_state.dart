import 'package:image_picker/image_picker.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/premieum/data/model/premieum.dart';

class PremieumState {
  final UiState uiState;
  final List<Premieum> premieum;
  final String? erroemessage;
  final List<XFile>? images;
  final bool isFormSent;

  PremieumState({
    this.uiState = UiState.loading,
    this.premieum = const [],
    this.images = const [],
    this.erroemessage,
    this.isFormSent = false,
  });

  PremieumState copyWith({
    UiState? uiState,
    List<Premieum>? premieum,
    String? erroemessage,
    List<XFile>? images,
    bool? isFormSent,
  }) {
    return PremieumState(
      erroemessage: erroemessage ?? this.erroemessage,
      uiState: uiState ?? this.uiState,
      premieum: premieum ?? this.premieum,
      images: images ?? this.images,
      isFormSent: isFormSent ?? this.isFormSent,
    );
  }
}
