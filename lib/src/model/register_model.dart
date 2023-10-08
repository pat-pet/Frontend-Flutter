import 'dart:convert';

RegisterData registerDataFromJson(String str) =>
    RegisterData.fromJson(json.decode(str));

String registerDataToJson(RegisterData data) => json.encode(data.toJson());

class RegisterData {
  List<UserModel>? users;

  RegisterData({
    this.users,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        users: json["users"] == null
            ? []
            : List<UserModel>.from(
                json["users"]!.map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class UserModel {
  int? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? password;
  String? statusAnimalCare;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.password,
    this.statusAnimalCare,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        statusAnimalCare: json["status_animal_care"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "status_animal_care": statusAnimalCare,
      };
}
