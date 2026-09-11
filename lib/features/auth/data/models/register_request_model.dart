class RegisterRequestModel {
  final String fullName;
  final String email;
  final String password;
  final int age;

  const RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.age,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'password': password,
    'age': age,
  };
}
