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

class AuthCubit extends Cubit<BaseState<UserEntity>> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final BiometricUseCase biometricUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.biometricUseCase,
    required this.signOutUseCase,
  }) : super(const BaseInitial());

  Future<void> signIn(SignInRequest request) async {
    emit(const BaseLoading());
    final result = await signInUseCase(request);
    if (isClosed) return;
    if (result is ApiSuccess<UserEntity>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<UserEntity>) {
      emit(BaseError(result.error));
    }
  }

  Future<void> biometricLogin() async {
    emit(const BaseLoading());
    try {
      final success = await biometricUseCase();
      if (isClosed) return;
      if (success) {
        emit(const BiometricSuccess());
      } else {
        emit(const BaseError('Biometric authentication failed'));
      }
    } catch (e) {
      if (!isClosed) emit(BaseError(e.toString()));
    }
  }

  Future<void> signUp(SignUpRequest request) async {
    emit(const BaseLoading());
    final result = await signUpUseCase(request);
    if (isClosed) return;
    if (result is ApiSuccess<UserEntity>) {
      emit(BaseSuccess(result.data));
    } else if (result is ApiFailure<UserEntity>) {
      emit(BaseError(result.error));
    }
  }

  Future<void> signOut() async {
    emit(const BaseLoading());
    final result = await signOutUseCase();
    if (isClosed) return;
    if (result is ApiSuccess<bool>) {
      emit(const SignOutSuccess());
    } else if (result is ApiFailure<bool>) {
      emit(BaseError(result.error));
    }
  }
}
