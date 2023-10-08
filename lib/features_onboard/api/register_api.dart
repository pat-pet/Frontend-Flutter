import 'package:dio/dio.dart';
import 'package:frontend_flutter/features_onboard/model/register_model.dart';

import '../utils/token_manager.dart';

class ApiUser {
  final String urlRegister = 'http://192.168.1.4:39390/users/register';
  final String urlLogin = 'http://192.168.1.4:39390/users/login';

  var error = '';
  var message = '';

  Future<User> registerUser(User user) async {
    final response = await Dio().post(urlRegister, data: user.toJson());
    if (response.statusCode == 201) {
      return User.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<User> login(String email, String password) async {
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

      return User.fromJson(response.data);
    } else if (response.statusCode == 400) {
      error = response.statusMessage.toString();

      return User.fromJson(response.data);
    } else if (response.statusCode == 404) {
      error = response.statusMessage.toString();

      return User.fromJson(response.data);
    } else {
      throw Exception('Failed to login');
    }
  }
}
