import 'package:dio/dio.dart';
import 'exceptions.dart';

class ErrorHandler {
  static ServerException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ServerException("الانترنت بطيء،تحقق من اتصالك");
      case DioExceptionType.sendTimeout:
        return ServerException("الانترنت بطيء،تحقق من اتصالك");
      case DioExceptionType.receiveTimeout:
        return ServerException("الانترنت بطيء،تحقق من اتصالك");
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data?['message'] ?? "خطأ في الاستجابة من الخادم";
        return ServerException("خطأ ($statusCode): $message");
      case DioExceptionType.cancel:
        return ServerException("تم إلغاء الطلب");
      case DioExceptionType.connectionError:
        return ServerException("لا يوجد اتصال بالإنترنت");
      default:
        return ServerException("حدث خطأ غير متوقع. حاول لاحقاً");
    }
  }
}
