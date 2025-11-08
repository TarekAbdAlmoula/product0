import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/notification/data/model/notification.dart';

class NotificationState {
  final UiState? uiState;
  final List<Notifications> notification;
  final String? erroemessage;

  NotificationState({
    this.uiState,
    this.notification = const [],
    this.erroemessage,
  });

  NotificationState copyWith({
    String? erroemessage,
    UiState? uiState,
    List<Notifications>? notification,
  }) {
    return NotificationState(
      uiState: uiState ?? this.uiState,
      notification: notification ?? this.notification,
      erroemessage: erroemessage ?? this.erroemessage,
    );
  }
}
