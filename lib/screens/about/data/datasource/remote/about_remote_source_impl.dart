import 'package:dio/dio.dart';
import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/core/utils/error_handler.dart';
import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/about/data/datasource/remote/about_remote_source.dart';

class AboutRemoteSourceImpl implements AboutRemoteSource {
  final ApiConsumer api;
  AboutRemoteSourceImpl({required this.api});
  @override
  Future getAboutInfo() async {
    try {
      var response = await api.get(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/about_app',
      );
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }
}
