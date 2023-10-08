import 'package:frontend_flutter/src/model/register_model.dart';

class LoginResponse {
  String? token;
  UserModel? user;

  LoginResponse({this.token, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = UserModel.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user?.toJson(),
      };
}
