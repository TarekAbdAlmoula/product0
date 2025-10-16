import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:product0/core/api/api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio});

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    final String key = 'x-api-key';
    final String value = r'wMoo0]{Jkq9r_Vw!8LSD,p#2X$Aq7';

    final option = Options(
      headers: {key: value, 'Authorization': 'Bearer $token'},
    );
    final optionWithoutToken = Options(headers: {key: value});
    var res = await dio.get(
      path,
      queryParameters: queryParameters,
      options: token == null ? optionWithoutToken : option,
    );
    return res.data;
  }

  @override
  Future post(String path, {dynamic data, String? token}) async {
    final String key = 'x-api-key';
    final String value = r'wMoo0]{Jkq9r_Vw!8LSD,p#2X$Aq7';
    final option = Options(
      headers: {key: value, "Authorization": "Bearer$token"},
    );
    final optionWithoutToken = Options(headers: {key: value});
    var res = await dio.post(
      path,
      data: data,
      options: token == null ? optionWithoutToken : option,
    );
    return res.data;
  }
}
