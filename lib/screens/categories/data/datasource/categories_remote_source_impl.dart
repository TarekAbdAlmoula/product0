import 'package:dio/dio.dart';
import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/core/utils/error_handler.dart';
import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/categories/data/datasource/categories_remote_source.dart';

class CategoriesRemoteSourceImpl implements CategoriesRemoteSource {
  final ApiConsumer api;
  CategoriesRemoteSourceImpl({required this.api});
  @override
  Future getCategoriesById(int id) async {
    try {
      var response = await api.get(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/services_categories?parent_id=$id&_fields=name,image,id',
      );
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }
}
