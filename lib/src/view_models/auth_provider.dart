import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/src/api/authentication_api.dart';
import 'package:frontend_flutter/src/model/register_model.dart';
import 'package:frontend_flutter/src/utils/token_manager.dart';

enum LoginStatus { empty, loading, success, error }

class AuthProvider extends ChangeNotifier {
  LoginStatus _loginStatus = LoginStatus.empty;
  LoginStatus get loginStatus => _loginStatus;

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  String _message = '';
  String get message => _message;

  final String _error = '';
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

  Future<void> register(UserModel user) async {
    notifyListeners();
    try {
      final result = await AuthenticationApi().registerUser(user);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _loginStatus = LoginStatus.loading;
    notifyListeners();
    try {
      final result = await AuthenticationApi().login(email, password);
      SharedPrefManager.saveString(
        SharedPrefManager.tokenKey,
        result.token?.toString() ?? "",
      );
      SharedPrefManager.saveString(
        SharedPrefManager.idKey,
        result.user?.id.toString() ?? "",
      );
      SharedPrefManager.saveString(
        SharedPrefManager.fullNameKey,
        result.user?.fullName.toString() ?? "",
      );
      SharedPrefManager.saveString(
        SharedPrefManager.emailKey,
        result.user?.email.toString() ?? "",
      );
      SharedPrefManager.saveString(
        SharedPrefManager.phoneNumberKey,
        result.user?.phoneNumber.toString() ?? "",
      );
      SharedPrefManager.saveString(
        SharedPrefManager.statusAnimalCareKey,
        result.user?.statusAnimalCare.toString() ?? "",
      );
      _loginStatus = LoginStatus.success;
      notifyListeners();
    } on DioException catch (e) {
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
