import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _tokenKey = 'bearer_token';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}

class LoginManager {
  static Future<void> saveLogin(bool isLogin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', isLogin);
  }

  static Future<bool?> removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('isLogin');
  }
}
