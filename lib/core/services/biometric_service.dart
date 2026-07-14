import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth;

  BiometricService(this._auth);

  Future<bool> authenticate() async {
    try {
      final isSupported = await _auth.isDeviceSupported();
      if (!isSupported) {
        throw Exception('Biometrics not supported on this device');
      }

      final canCheck = await _auth.canCheckBiometrics;
      if (!canCheck) {
        throw Exception('Biometrics not available on this device');
      }

      final enrolledBiometrics = await _auth.getAvailableBiometrics();
      if (enrolledBiometrics.isEmpty) {
        throw Exception(
            'No biometrics enrolled. Please set up biometrics in settings.');
      }

      return await _auth.authenticate(
        localizedReason: 'Authenticate to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        throw Exception('Biometric authentication is not available.');
      } else if (e.code == auth_error.notEnrolled) {
        throw Exception('No biometrics enrolled on this device.');
      } else if (e.code == auth_error.lockedOut) {
        throw Exception(
            'Biometric authentication is locked out due to too many attempts.');
      } else if (e.code == auth_error.permanentlyLockedOut) {
        throw Exception(
            'Biometric authentication is permanently locked. Please use screen lock passcode.');
      } else {
        throw Exception(
            'Biometric authentication error: ${e.message ?? e.code}');
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
