import '../repository_interface/biometric_repository.dart';

class BiometricUseCase {

  final BiometricRepository repository;

  BiometricUseCase(this.repository);

  Future<bool> call() {
    return repository.authenticate();
  }
}