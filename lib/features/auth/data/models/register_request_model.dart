class RegisterRequestModel {
  final String fullName;
  final String email;
  final String password;
  final String role;
  final int age;

  const RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.age,
    this.role = 'Child',
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'password': password,
    'age': age,
    'role': role,
  };
}
