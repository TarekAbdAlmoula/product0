import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:product0/core/api/api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio});

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    final String userName = 'ck_710929f98f0cf058a709fb17508b94e498f3e71b';
    final String password = 'cs_62153c7de043378d1a3e1cb3345e1657aa182c09';
    final option = Options(
      headers: {
        "authorization":
            'Basic ${base64Encode(utf8.encode('$userName:$password'))}',
      },
    );
    var res = await dio.get(
      path,
      queryParameters: queryParameters,
      options: option,
    );
    return res.data;
  }

  @override
  Future post(String path, {data}) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
