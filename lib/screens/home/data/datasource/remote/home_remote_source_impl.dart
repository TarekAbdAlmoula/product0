import 'dart:async';

import 'package:dio/dio.dart';
import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/core/utils/error_handler.dart';
import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/home/data/datasource/remote/home_remote_source.dart';

class HomeRemoteSourceImpl implements HomeRemoteSource {
  final ApiConsumer api;
  HomeRemoteSourceImpl({required this.api});
  @override
  Future getProducts() async {
    try {
      var response = await api.get(
        'https://barmijha.net/test/wp-json/wc/v3/products?_fields=id,name,short_description,price,images,featured,rating_count&per_page=100',
      );
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  Future getCategories() async {
    try {
      var response = await api.get(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/services_categories?parent=0',
      );
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Get products by category id.
  ///
  /// [id] is the id of the category.
  ///
  /*******  80cd4636-665a-4929-92a0-3d4d54bbfb5a  *******/
  Future getProductsByCategory(int id) async {
    try {
      var response = await api.get(
        'https://barmijha.net/test/wp-json/wc/v3/products?category=$id&_fields=id,name,price,images,rating_count,featured,short_description&per_page=100',
      );
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  Future getAdds({String? token}) async {
    try {
      var response = await api.get(
        token: token,
        'https://wasla.barmijha.net/wp-json/custom-api/v1/ads',
      );
      print(response);
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  Future getFeaturedWorkshops() async {
    try {
      var response = await api.get(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/services_simple?category=العقارات&exclude=true&is_featured=true',
      );
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  Future getTopRatedWorkshop() async {
    try {
      var response = await api.get(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/services_simple',
      );
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  Future getUserPoints({required String token}) async {
    try {
      var response = await api.get(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/user_points',
        token: token,
      );

      return response['points'];
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  Future addPoints({required String action, required String token}) async {
    try {
      var response = await api.post(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/user_points',
        data: {"action": action},
        token: token,
      );
      print(response['message']);
      return response['message'];
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  Future searchWorkshops({required String query}) async {
    try {
      var response = await api.get(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/search?query=$query',
      );

      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  Future getPointsExpl() async {
    try {
      var response = await api.get(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/about_app',
      );
      return response[1]['about_us'];
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }
}
