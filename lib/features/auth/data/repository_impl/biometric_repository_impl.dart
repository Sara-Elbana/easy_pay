import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import '../../domain/repository_interface/biometric_repository.dart';

class BiometricRepositoryImpl implements BiometricRepository {
  final LocalAuthentication auth;

  BiometricRepositoryImpl(this.auth);

  @override
  Future<bool> authenticate() async {
    try {
      final isSupported = await auth.isDeviceSupported();
      if (!isSupported) {
        throw Exception('Biometrics not supported on this device');
      }

      final canCheck = await auth.canCheckBiometrics;
      if (!canCheck) {
        throw Exception('Biometrics not available on this device');
      }

      final enrolledBiometrics = await auth.getAvailableBiometrics();
      if (enrolledBiometrics.isEmpty) {
        throw Exception('No biometrics enrolled. Please set up biometrics in settings.');
      }

      final success = await auth.authenticate(
        localizedReason: 'Authenticate to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      return success;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        throw Exception('Biometric authentication is not available.');
      } else if (e.code == auth_error.notEnrolled) {
        throw Exception('No biometrics enrolled on this device.');
      } else if (e.code == auth_error.lockedOut) {
        throw Exception('Biometric authentication is locked out due to too many attempts.');
      } else if (e.code == auth_error.permanentlyLockedOut) {
        throw Exception('Biometric authentication is permanently locked. Please use screen lock passcode.');
      } else {
        throw Exception('Biometric authentication error: ${e.message ?? e.code}');
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}