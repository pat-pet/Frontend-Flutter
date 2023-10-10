import 'package:flutter/material.dart';
import 'package:frontend_flutter/src/api/authentication_api.dart';
import 'package:frontend_flutter/src/model/register_model.dart';
import 'package:frontend_flutter/src/utils/token_manager.dart';

enum HomeStatus { empty, loading, success, error }

class HomeProvider extends ChangeNotifier {
  HomeStatus _homeStatus = HomeStatus.empty;
  HomeStatus get homeStatus => _homeStatus;

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  final String _error = '';
  String get error => _error;

  String _message = '';
  String get message => _message;

  Future<void> getUsers() async {
    _homeStatus = HomeStatus.loading;
    notifyListeners();
    try {
      final token =
          await SharedPrefManager.getString(SharedPrefManager.tokenKey);
      final userId = await SharedPrefManager.getString(SharedPrefManager.idKey);
      final result = await AuthenticationApi().getUsers(token ?? "");
      _users =
          result.where((element) => element.id.toString() != userId).toList();
      _homeStatus = HomeStatus.success;
      notifyListeners();
    } catch (e) {
      _message = e.toString();
      _homeStatus = HomeStatus.error;
      notifyListeners();
    }
  }
}
