import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/screens/notification/data/datasource/notification_remote_source.dart';

class NotificationRemoteSourceImpl implements NotificationRemoteSource {
  final ApiConsumer api;
  NotificationRemoteSourceImpl({required this.api});
  @override
  Future getNotifications() async {
    var response = await api.get(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/notifications',
    );
    return response;
  }
}
