import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_in_request.dart';
import 'package:easy_pay_app/features/auth/data/models/requests/sign_up_request.dart';
import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/biometric_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_out_usecase.dart';
import 'package:easy_pay_app/features/auth/domain/use_cases/sign_up_usecase.dart';
import 'package:easy_pay_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final BiometricUseCase biometricUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.biometricUseCase,
    required this.signOutUseCase,
  }) : super(const AuthInitial());

  Future<void> signIn(SignInRequest request) async {
    emit(const AuthLoading());
    final result = await signInUseCase(request);
    if (result is ApiSuccess<UserEntity>) {
      emit(AuthSuccess(result.data));
    } else if (result is ApiFailure<UserEntity>) {
      emit(AuthFailure(result.error));
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
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp(SignUpRequest request) async {
    emit(const AuthLoading());
    final result = await signUpUseCase(request);
    if (result is ApiSuccess<UserEntity>) {
      emit(AuthSuccess(result.data));
    } else if (result is ApiFailure<UserEntity>) {
      emit(AuthFailure(result.error));
    }
  }

  Future<void> signOut() async {
    emit(const AuthLoading());
    final result = await signOutUseCase();
    if (result is ApiSuccess<bool>) {
      emit(const SignOutSuccess());
    } else if (result is ApiFailure<bool>) {
      emit(AuthFailure(result.error));
    }
  }
}
