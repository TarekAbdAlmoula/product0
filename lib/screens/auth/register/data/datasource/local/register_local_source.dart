abstract class RegisterLocalSource {
  Future<void> saveUserData({
    required String username,
    required String password,
    required num userId,
    required String email,
    required String accountType,
  });
}
