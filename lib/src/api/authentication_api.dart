import 'package:dio/dio.dart';
import 'package:frontend_flutter/src/model/login_response.dart';
import 'package:frontend_flutter/src/model/register_model.dart';

import '../utils/token_manager.dart';

class AuthenticationApi {
  final String urlRegister = 'http://192.168.100.24:3000/users/register';
  final String urlLogin = 'http://192.168.100.24:3000/users/login';
  final String urlUsers = "http://192.168.100.24:3000";

  var error = '';
  var message = '';

  Future<List<UserModel>> getUsers(String token) async {
    final response = await Dio().get(
      urlUsers,
      options: Options(
        headers: {
          'token': token,
        },
      ),
    );

    if (response.statusCode == 200) {
      List<UserModel> users = response.data['users']
          .map<UserModel>((user) => UserModel.fromJson(user))
          .toList();

      return users;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<UserModel> registerUser(UserModel user) async {
    final response = await Dio().post(urlRegister, data: user.toJson());
    if (response.statusCode == 201) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    final response = await Dio().post(
      urlLogin,
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final token = response.data['token'];
      TokenManager.saveToken(token);
      return LoginResponse.fromJson(response.data);
    } else if (response.statusCode == 400) {
      error = response.statusMessage.toString();
      return LoginResponse.fromJson(response.data);
    } else if (response.statusCode == 404) {
      error = response.statusMessage.toString();
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to login');
    }
  }
}
