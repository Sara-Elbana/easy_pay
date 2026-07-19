import 'package:flutter/material.dart';
import 'package:easy_pay_app/core/theme/app_colors.dart';

class CurrencyInputField extends StatefulWidget {
  final String label;
  final String selectedCurrency;
  final String amount;
  final bool readOnly;
  final ValueChanged<String>? onAmountChanged;
  final VoidCallback onCurrencyTap;

  const CurrencyInputField({
    super.key,
    required this.label,
    required this.selectedCurrency,
    required this.amount,
    this.readOnly = false,
    this.onAmountChanged,
    required this.onCurrencyTap,
  });

  @override
  State<CurrencyInputField> createState() => _CurrencyInputFieldState();
}

class _CurrencyInputFieldState extends State<CurrencyInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.amount);
  }

  @override
  void didUpdateWidget(covariant CurrencyInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.amount != oldWidget.amount && widget.amount != _controller.text) {
      _controller.text = widget.amount;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF979797),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 65,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFBFBFBF), width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _controller,
                    readOnly: widget.readOnly,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: widget.onAmountChanged,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray900,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Amount',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFCACACA),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 34,
                color: const Color(0xFFBFBFBF),
              ),
              GestureDetector(
                onTap: widget.onCurrencyTap,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.selectedCurrency,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray900,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_up,
                            size: 14,
                            color: Color(0xFF898989),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 14,
                            color: Color(0xFF898989),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
