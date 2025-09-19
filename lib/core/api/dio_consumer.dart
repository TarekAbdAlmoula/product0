import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:product0/core/api/api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio});

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    final String key = 'x-api-key';
    final String value = r'wMoo0]{Jkq9r_Vw!8LSD,p#2X$Aq7';

    final option = Options(headers: {key: value});
    var res = await dio.get(
      path,
      queryParameters: queryParameters,
      options: option,
    );
    return res.data;
  }

  @override
  Future post(String path, {data}) async {
    var res = await dio.post(path, data: data);
    return res.data;
  }
}
