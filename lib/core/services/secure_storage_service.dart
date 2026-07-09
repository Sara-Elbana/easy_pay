import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  const SecureStorageService();

  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
  );

  /// Write a value to secure storage
  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Read a value from secure storage
  Future<String?> read({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  /// Delete a specific key
  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  /// Delete all entries
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  /// Check if a key exists
  Future<bool> containsKey({required String key}) async {
    final value = await _secureStorage.read(key: key);
    return value != null;
  }

  /// Get all keys
  Future<Map<String, String>> readAll() async {
    return await _secureStorage.readAll();
  }

  // Convenience methods for sensitive data
  Future<void> saveAccessToken(String token) =>
      write(key: 'access_token', value: token);

  Future<String?> getAccessToken() => read(key: 'access_token');

  Future<void> deleteAccessToken() => delete(key: 'access_token');

  Future<void> saveRefreshToken(String token) =>
      write(key: 'refresh_token', value: token);

  Future<String?> getRefreshToken() => read(key: 'refresh_token');

  Future<void> deleteRefreshToken() => delete(key: 'refresh_token');

  Future<void> saveBiometricPin(String pin) =>
      write(key: 'biometric_pin', value: pin);

  Future<String?> getBiometricPin() => read(key: 'biometric_pin');

  Future<void> deleteBiometricPin() => delete(key: 'biometric_pin');

  Future<void> clearSensitiveData() async {
    await deleteAccessToken();
    await deleteRefreshToken();
    await deleteBiometricPin();
  }
}
