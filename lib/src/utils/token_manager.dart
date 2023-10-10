import 'package:frontend_flutter/src/model/register_model.dart';
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

class SharedPrefManager {
  static const String tokenKey = "token_key";
  static const String idKey = "id_key";
  static const String emailKey = "email_key";
  static const String fullNameKey = "full_name_key";
  static const String phoneNumberKey = "phone_number_key";
  static const String statusAnimalCareKey = "status_animal_care_key";

  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(tokenKey);
    prefs.remove(idKey);
    prefs.remove(fullNameKey);
    prefs.remove(emailKey);
    prefs.remove(statusAnimalCareKey);
  }
}
