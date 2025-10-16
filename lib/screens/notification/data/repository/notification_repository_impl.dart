import 'package:product0/screens/notification/data/datasource/notification_remote_source.dart';
import 'package:product0/screens/notification/data/model/notification.dart';
import 'package:product0/screens/notification/data/repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteSource notificationRemoteSource;

  NotificationRepositoryImpl({required this.notificationRemoteSource});
  @override
  Future getNotifications() async {
    List<Notifications> notifications = [];
    var response = await notificationRemoteSource.getNotifications();
    for (var data in response) {
      notifications.add(Notifications.fromJson(data));
    }
    return notifications;
  }
}
