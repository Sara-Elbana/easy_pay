/// Email validator
class EmailValidator {
  static const String _emailRegex =
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';

  static bool isValid(String email) {
    if (email.isEmpty) return false;
    final regex = RegExp(_emailRegex);
    return regex.hasMatch(email);
  }

  static String? validate(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!isValid(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}

/// Password validator
class PasswordValidator {
  static const int minLength = 8;

  /// Validates password with minimum requirements
  static bool isValid(String password) {
    if (password.length < minLength) return false;
    // Contains uppercase
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    // Contains lowercase
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    // Contains digit
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    return true;
  }

  static String? validate(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain an uppercase letter';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain a lowercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a number';
    }
    return null;
  }
}

/// Phone number validator
class PhoneValidator {
  /// Validates phone number (basic format)
  static bool isValid(String phone) {
    final regex = RegExp(r'^\(\+[0-9]+\)\s*[0-9]{10}$');
    return regex.hasMatch(phone.trim());
  }

  static String? validate(String phone) {
    if (phone.isEmpty) {
      return 'Phone number is required';
    }
    if (!isValid(phone)) {
      return 'Phone number must start with country code in parentheses e.g. (+20) followed by 10 digits';
    }
    return null;
  }
}

/// Required field validator
class RequiredFieldValidator {
  static bool isValid(String value) => value.trim().isNotEmpty;

  static String? validate(String value, {String fieldName = 'Field'}) {
    if (!isValid(value)) {
      return '$fieldName is required';
    }
    return null;
  }
}

/// National ID validator (placeholder for banking app)
class NationalIdValidator {
  /// Validates national ID format (can be customized per country)
  static bool isValid(String id) {
    final cleanId = id.replaceAll(RegExp(r'[^\d]'), '');
    // Customize based on your country requirements
    // Example: 9-11 digits for most countries
    return cleanId.length >= 9 && cleanId.length <= 11;
  }

  static String? validate(String id) {
    if (id.isEmpty) {
      return 'National ID is required';
    }
    if (!isValid(id)) {
      return 'Enter a valid National ID';
    }
    return null;
  }
}

/// Amount validator for financial transactions
class AmountValidator {
  static const double minAmount = 0.01;
  static const double maxAmount = 999999.99;

  static bool isValid(String amount) {
    try {
      final value = double.parse(amount);
      if (value < minAmount || value > maxAmount) return false;
      // Check decimal places
      final parts = amount.split('.');
      if (parts.length > 1 && parts[1].length > 2) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  static String? validate(String amount) {
    if (amount.isEmpty) {
      return 'Amount is required';
    }
    try {
      final value = double.parse(amount);
      if (value < minAmount) {
        return 'Amount must be at least $minAmount';
      }
      if (value > maxAmount) {
        return 'Amount exceeds maximum limit';
      }
      final parts = amount.split('.');
      if (parts.length > 1 && parts[1].length > 2) {
        return 'Maximum 2 decimal places allowed';
      }
    } catch (e) {
      return 'Enter a valid amount';
    }
    return null;
  }
}
