class User {
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? userType;
  final String? phoneNumber;
  final String? token;
  final bool isLoggedIn;
  final int? userId;
  User({
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.userType,
    this.phoneNumber,
    this.token,
    this.isLoggedIn = false,
    this.userId,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['user_email'],
      password: json['password'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userType: json['account_type'],
      phoneNumber: json['phone_number'],
      token: json['token'],
      isLoggedIn: json['success'],
      userId: json['id'],
    );
  }
  //add to string funstion
  @override
  String toString() {
    return 'User(email: $email, password: $password, firstName: $firstName, lastName: $lastName, userType: $userType, phoneNumber: $phoneNumber, token: $token)';
  }
}
