import 'dart:async';

import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/screens/details/data/remote/details_remote_source.dart';

class DetailsRemoteSourceImpl implements DetailsRemoteSource {
  final ApiConsumer api;
  DetailsRemoteSourceImpl({required this.api});
  @override
  Future sendRating(
    num rating,
    int workshopId,
    String token, {
    String? comment,
  }) async {
    var response = await api.post(
      'https://wasla.barmijha.net/wp-json/custom-api/v1/rate-service',
      data: {"service_id": "$workshopId", "rating": rating, "comment": comment},
      token: token,
    );
    print(response);
    return response;
  }
}
