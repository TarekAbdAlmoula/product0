import 'dart:async';

import 'package:dio/dio.dart';
import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/core/utils/error_handler.dart';
import 'package:product0/core/utils/exceptions.dart';
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
    try {
      var response = await api.post(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/rate-service',
        data: {
          "service_id": "$workshopId",
          "rating": rating,
          "comment": comment,
        },
        token: token,
      );
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  Future callService({
    required String token,
    required String workshopId,
  }) async {
    try {
      await api.post(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/call_service',
        data: {"workshop_id": workshopId},
        token: token,
      );
    } on Exception catch (e) {}
  }
}
