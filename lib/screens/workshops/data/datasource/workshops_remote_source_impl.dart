import 'package:dio/dio.dart';
import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/core/utils/error_handler.dart';
import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/workshops/data/datasource/workshops_remote_source.dart';

class WorkshopsRemoteSourceImpl extends WorkshopRemoteSource {
  final ApiConsumer api;
  WorkshopsRemoteSourceImpl(this.api);
  @override
  Future getProductsByCategory(int id) async {
    try {
      var response = await api.get(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/services_simple?category=$id',
      );
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }
}
