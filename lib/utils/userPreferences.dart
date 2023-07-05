import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const _keyUserEmail = 'userEmail';
  static const _keyUserPassword = 'userPassword';
  static const _keyUserToken = 'userToken';

  Future<void> setUserLogin(String userEmail, String userPassword) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(_keyUserEmail, userEmail);
    await prefs.setString(_keyUserPassword, userPassword);
  }

  Future<void> setUserToken(String userToken) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(_keyUserToken, userToken);
  }

  Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_keyUserEmail);
  }

  Future<String?> getUserPassword() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_keyUserPassword);
  }

  Future<String?> getUserToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_keyUserToken);
  }

  Future<void> cleanUser() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
