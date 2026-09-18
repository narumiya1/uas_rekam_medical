// lib/app/data/services/auth_service.dart

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPrefService extends GetxService {
  late SharedPreferences _prefs;

  // Kunci untuk shared preferences
  static const String _KEY_IS_LOGGED_IN = 'isLoggedIn';
  static const String _KEY_USER_ROLE_ADMIN =
      'userRoleAdmin'; // Contoh: 'admin', 'user', 'guest'

  Future<MyPrefService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // --- Methods untuk Login Status ---
  bool get isLoggedIn => _prefs.getBool(_KEY_IS_LOGGED_IN) ?? false;

  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(_KEY_IS_LOGGED_IN, value);
  }

  // --- Methods untuk User Role ---
  String? get userRoleAdmin => _prefs.getString(_KEY_USER_ROLE_ADMIN);
  Future<void> setUserRoleAdmin(String role) async {
    await _prefs.setString(_KEY_USER_ROLE_ADMIN, role);
  }

  // --- Method untuk Logout ---
  Future<void> logout() async {
    await _prefs.remove(_KEY_IS_LOGGED_IN);
    await _prefs.remove(_KEY_USER_ROLE_ADMIN);
  }
}
