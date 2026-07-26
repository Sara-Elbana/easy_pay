class UserResponseModel {
  final int id;
  final String name;
  final String phone;

  UserResponseModel({required this.id, required this.name, required this.phone});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
    );
  }
}