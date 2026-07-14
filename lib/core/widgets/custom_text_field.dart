import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.inputFormatters,
    this.enabled = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: widget.inputFormatters,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.enabled
            ? AppColors.inputBackground
            : AppColors.gray100.withValues(alpha: 0.5),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.enabled
              ? AppColors.textLight
              : AppColors.textLight.withValues(alpha: 0.5),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              const BorderSide(color: AppColors.inputBorder, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              BorderSide(color: AppColors.inputBorder.withValues(alpha: 0.5), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        errorStyle: const TextStyle(
          color: AppColors.error,
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.inputBorder, width: 1.5),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textLight,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
