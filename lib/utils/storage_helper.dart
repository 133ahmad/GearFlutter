import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper extends GetxService {
  late final SharedPreferences _prefs;

  Future<StorageHelper> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<String?> getToken() async {
    return _prefs.getString('auth_token');
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString('auth_token', token);
  }

  Future<void> clearToken() async {
    await _prefs.remove('auth_token');
  }
}