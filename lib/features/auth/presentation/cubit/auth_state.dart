export 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/core/cubit/base_state.dart';
import 'package:easy_pay_app/features/auth/domain/entities/user_entity.dart';

typedef AuthState = BaseState<UserEntity>;

class BiometricSuccess extends BaseState<UserEntity> {
  const BiometricSuccess();
}

class SignOutSuccess extends BaseState<UserEntity> {
  const SignOutSuccess();
}
