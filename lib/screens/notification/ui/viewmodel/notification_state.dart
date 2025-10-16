import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/notification/data/model/notification.dart';

class NotificationState {
  final UiState? uiState;
  final List<Notifications> notification;
  NotificationState({this.uiState, this.notification = const []});

  NotificationState copyWith({
    UiState? uiState,
    List<Notifications>? notification,
  }) {
    return NotificationState(
      uiState: uiState ?? this.uiState,
      notification: notification ?? this.notification,
    );
  }
}
