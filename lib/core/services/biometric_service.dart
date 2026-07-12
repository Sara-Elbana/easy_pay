import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final canCheckBiometric = await auth.canCheckBiometrics;
      final isSupported = await auth.isDeviceSupported();

      if (!canCheckBiometric || !isSupported) {
        return false;
      }

      return await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}