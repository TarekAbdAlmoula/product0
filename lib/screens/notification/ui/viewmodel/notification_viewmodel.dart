import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/notification/data/model/notification.dart';
import 'package:product0/screens/notification/data/repository/notification_repository_impl.dart';
import 'package:product0/screens/notification/ui/viewmodel/notification_State.dart';

class NotificationViewmodel extends Cubit<NotificationState> {
  final NotificationRepositoryImpl notificationRepositoryImpl;
  NotificationViewmodel({required this.notificationRepositoryImpl})
    : super(NotificationState(uiState: UiState.data)) {
    init();
  }
  Future init() async {
    await getNotifications();
  }

  Future getNotifications() async {
    emit(state.copyWith(uiState: UiState.loading));
    try {
      List<Notifications> notifications = await notificationRepositoryImpl
          .getNotifications();
      emit(state.copyWith(uiState: UiState.data, notification: notifications));
    } catch (e) {}
  }
}
