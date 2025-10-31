abstract class AuthLocalSource {
  Future<void> saveUserData({
    required String username,
    required String password,
    required num userId,
    required String email,
    required String accountType,
    required String phoneNumber,
    required String location,
    String? token,
  });

  Future<void> getData(String data);
  Future<void> saveSpecificData({required String value});
}
