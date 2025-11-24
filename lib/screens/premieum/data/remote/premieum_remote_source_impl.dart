import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product0/core/api/api_consumer.dart';
import 'package:product0/core/utils/error_handler.dart';
import 'package:product0/core/utils/exceptions.dart';
import 'package:product0/screens/premieum/data/remote/premieum_remote_source.dart';

class PremieumRemoteSourceImpl implements PremieumRemoteSource {
  final ApiConsumer api;
  PremieumRemoteSourceImpl({required this.api});
  @override
  Future getPlans() async {
    try {
      var response = await api.get(
        'https://wasla.barmijha.net/wp-json/custom-api/v1/premium',
      );
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }

  @override
  Future uploadImages({
    required List<XFile>? images,
    required String token,
    required String productName,
    required String productDescription,
    required String location,
    required String phoneNumber,
    String price = '',
  }) async {
    try {
      List<MultipartFile> imageFiles = [];

      for (int i = 0; i < images!.length; i++) {
        imageFiles.add(
          await MultipartFile.fromFile(
            images[i].path,
            filename: "image_$i.jpg",
          ),
        );
      }

      FormData formData = FormData.fromMap({
        "title": productName,
        "description": "$productDescription $price",
        "address": location,
        "phone": phoneNumber,
        "images[]": imageFiles,
      });

      var response = await Dio().post(
        "https://wasla.barmijha.net/wp-json/custom-api/v1/add_service",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      return response.data['success'];
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ServerException("حدث خطأ غير متوقع ");
    }
  }
}
