class Validators{
  Validators._();
  static String? validateName(String? value){
    if(value == null || value.trim().isEmpty){
      return "Please enter your name";
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  static String? validateConfirmPassword(String? value, String password){
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    if (value.trim() != password.trim()) {
      return 'Password does not match';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    final regex = RegExp(r'^\(\+[0-9]+\)\s*[0-9]{10}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Phone number must start with country code in parentheses e.g. (+20) followed by 10 digits';
    }
    return null;
  }
}