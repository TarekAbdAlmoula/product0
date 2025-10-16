abstract class ApiConsumer {
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? token,
  });
  Future<dynamic> post(String path, {dynamic data, String? token});
}
