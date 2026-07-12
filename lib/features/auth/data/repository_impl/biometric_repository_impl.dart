import 'package:local_auth/local_auth.dart';
import '../../domain/repository_interface/biometric_repository.dart';

class BiometricRepositoryImpl implements BiometricRepository {

  final LocalAuthentication auth;

  BiometricRepositoryImpl(this.auth);

  @override
  Future<bool> authenticate() async {
    try {
      final canCheck = await auth.canCheckBiometrics;
      final supported = await auth.isDeviceSupported();

      if (!canCheck || !supported) {
        return false;
      }

      return await auth.authenticate(
        localizedReason: 'Authenticate to continue',
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