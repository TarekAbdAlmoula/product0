import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/screens/premieum/data/remote/premieum_remote_source.dart';

class PremieumRemoteSourceImpl implements PremieumRemoteSource {
  final ApiConsumer api;
  PremieumRemoteSourceImpl({required this.api});
  @override
  Future getPlans() async {
    var response = await api.get(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/premium',
    );
    return response;
  }
}
