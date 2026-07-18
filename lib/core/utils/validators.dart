import 'package:easy_localization/easy_localization.dart';

class Validators {
  Validators._();

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "err_enter_name".tr();
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'err_enter_email'.tr();
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'err_invalid_email'.tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'err_enter_password'.tr();
    }
    if (value.trim().length < 6) {
      return 'err_password_length'.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return 'err_enter_password'.tr();
    }
    if (value.trim() != password.trim()) {
      return 'err_password_mismatch'.tr();
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'err_enter_phone'.tr();
    }
    final regex = RegExp(r'^\+[0-9]{9,15}$');
    if (!regex.hasMatch(value.trim())) {
      return 'err_invalid_phone'.tr();
    }
    return null;
  }
}