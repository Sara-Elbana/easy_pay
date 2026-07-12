import 'package:easy_pay_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String username, String password);
  Future<UserModel> signUp(String name, String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> signIn(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Username and password cannot be empty');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }
    return UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Sarah Intern',
      username: username,
      password: password
    );
  }

  @override
  Future<UserModel> signUp(
      String name, String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (name.isEmpty || username.isEmpty || password.isEmpty) {
      throw Exception('All fields are required');
    }
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }
    return UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      username: username,
      password: password
    );
  }
}
