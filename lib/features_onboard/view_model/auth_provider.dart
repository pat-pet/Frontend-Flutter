import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pat_pat/features_onboard/api/register_api.dart';
import 'package:pat_pat/features_onboard/model/register_model.dart';

enum LoginStatus { empty, loading, success, error }

class AuthProvider extends ChangeNotifier {
  LoginStatus _loginStatus = LoginStatus.empty;
  LoginStatus get loginStatus => _loginStatus;

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  String _message = '';
  String get message => _message;

  String _error = '';
  String get error => _error;

  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  String _password = '';

  String get fullName => _fullName;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get password => _password;

  void setFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  void setLogout() {
    _isLogin = false;
    notifyListeners();
  }

  Future<void> register(User user) async {
    notifyListeners();
    try {
      final result = await ApiUser().registerUser(user);

      debugPrint('result: $result');
      notifyListeners();
    } catch (e) {
      print('Error : $e');
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _loginStatus = LoginStatus.loading;
    notifyListeners();
    try {
      final result = await ApiUser().login(email, password);

      debugPrint('result: $result');
      _loginStatus = LoginStatus.success;
      notifyListeners();
    } on DioError catch (e) {
      print('Error : $e');
      if (e.response != null && e.response!.statusCode == 400) {
        final errorMessage = e.response!.data[
            'errors']; // Assuming the response body contains a 'message' field

        _message = errorMessage;
      }

      _loginStatus = LoginStatus.error;

      notifyListeners();
    }
  }
}
