import 'package:easy_pay_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';
import 'package:easy_pay_app/features/auth/domain/repository_interface/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<UserEntity> signIn(String username, String password) async {
    try {
      return await remoteDataSource.signIn(username, password);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<UserEntity> signUp(
      String name, String username, String password) async {
    try {
      return await remoteDataSource.signUp(name, username, password);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
