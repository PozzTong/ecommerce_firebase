class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final dynamic age;
  final String gender;
  final String position;
  final String phone;
  final String email;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.position,
    required this.phone,
    required this.email,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? " ",
      firstName: json['first_name'] ?? " ",
      lastName: json['last_name'] ?? " ",
      age: json['age'] ?? 0,
      gender: json['gender'] ?? " ",
      position: json['position'] ?? " ",
      phone: json['phone'] ?? " ",
      email: json['email'] ?? " ",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name':lastName,
      'age':age,
      'gender':gender,
      'position':position,
      'phone':phone,
      'email':email,
    };
  }
}
