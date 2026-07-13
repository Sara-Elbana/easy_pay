import '../../../../core/services/biometric_service.dart';
import '../../domain/repository_interface/biometric_repository.dart';

class BiometricRepositoryImpl implements BiometricRepository {
  final BiometricService biometricService;

  BiometricRepositoryImpl(this.biometricService);

  @override
  Future<bool> authenticate() {
    return biometricService.authenticate();
  }
}