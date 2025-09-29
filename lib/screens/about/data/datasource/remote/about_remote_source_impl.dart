import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/screens/about/data/datasource/remote/about_remote_source.dart';

class AboutRemoteSourceImpl implements AboutRemoteSource {
  final ApiConsumer api;
  AboutRemoteSourceImpl({required this.api});
  @override
  Future getAboutInfo() async {
    var response = await api.get(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/about_app',
    );
    print(response);
    return response;
  }
}
