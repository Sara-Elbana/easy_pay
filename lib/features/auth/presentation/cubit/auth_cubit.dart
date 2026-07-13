import 'package:easy_pay_app/features/auth/domain/use_cases/biometric_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_up_usecase.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final BiometricUseCase biometricUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.biometricUseCase,
  }) : super(const AuthInitial());

  Future<void> signIn(String username, String password) async {
    emit(const AuthLoading());
    try {
      final user = await signInUseCase(username, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> biometricLogin() async {
    emit(const AuthLoading());
    try {
      final success = await biometricUseCase();
      if (success) {
        emit(const BiometricSuccess());
      } else {
        emit(const AuthFailure('Biometric authentication failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> signUp(String name, String username, String password) async {
    emit(const AuthLoading());
    try {
      final user = await signUpUseCase(name, username, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
