class UserModel {
  final String userId;
  final String fullName;
  final String role;
  final String authProvider;
  final int age;

  const UserModel({
    required this.userId,
    required this.fullName,
    required this.role,
    required this.authProvider,
    required this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      role: json['role'] as String? ?? '',
      authProvider: json['authProvider'] as String? ?? '',
      age: (json['age'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'role': role,
      'authProvider': authProvider,
      'age': age,
    };
  }
}
