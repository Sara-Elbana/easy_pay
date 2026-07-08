import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';

class SharedPreferencesService {
  late SharedPreferences _preferences;

  /// Initialize SharedPreferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // String Methods
  Future<bool> saveString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  // Boolean Methods
  Future<bool> saveBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  // Integer Methods
  Future<bool> saveInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  // Double Methods
  Future<bool> saveDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _preferences.getDouble(key) ?? defaultValue;
  }

  // StringList Methods
  Future<bool> saveStringList(String key, List<String> value) async {
    return await _preferences.setStringList(key, value);
  }

  List<String> getStringList(String key, {List<String>? defaultValue}) {
    return _preferences.getStringList(key) ?? defaultValue ?? [];
  }

  // Remove a key
  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  // Clear all data
  Future<bool> clear() async {
    return await _preferences.clear();
  }

  // Helper methods for common storage
  Future<bool> saveAccessToken(String token) =>
      saveString(AppConstants.accessTokenKey, token);

  String? getAccessToken() => getString(AppConstants.accessTokenKey);

  Future<bool> saveRefreshToken(String token) =>
      saveString(AppConstants.refreshTokenKey, token);

  String? getRefreshToken() => getString(AppConstants.refreshTokenKey);

  Future<bool> saveUserId(String userId) =>
      saveString(AppConstants.userIdKey, userId);

  String? getUserId() => getString(AppConstants.userIdKey);

  Future<bool> saveLanguage(String language) =>
      saveString(AppConstants.languageKey, language);

  String getLanguage({String defaultLanguage = 'en'}) =>
      getString(AppConstants.languageKey) ?? defaultLanguage;

  Future<bool> saveThemeMode(String themeMode) =>
      saveString(AppConstants.themeModeKey, themeMode);

  String getThemeMode({String defaultThemeMode = 'light'}) =>
      getString(AppConstants.themeModeKey) ?? defaultThemeMode;

  Future<bool> setFirstLaunchCompleted() =>
      saveBool(AppConstants.isFirstLaunchKey, false);

  bool isFirstLaunch() =>
      getBool(AppConstants.isFirstLaunchKey, defaultValue: true);

  Future<bool> saveOnboardingCompleted(bool value) =>
      saveBool(AppConstants.isOnboardingCompletedKey, value);

  bool isOnboardingCompleted() =>
      getBool(AppConstants.isOnboardingCompletedKey, defaultValue: false);
}
