import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class TransferFormSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController cardController;
  final TextEditingController amountController;
  final TextEditingController contentController;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onCardChanged;
  final ValueChanged<String> onAmountChanged;
  final ValueChanged<String> onContentChanged;

  final bool isEnabled;
  final bool isAmountExceeded;

  const TransferFormSection({
    super.key,
    required this.nameController,
    required this.cardController,
    required this.amountController,
    required this.contentController,
    required this.onNameChanged,
    required this.onCardChanged,
    required this.onAmountChanged,
    required this.onContentChanged,
    this.isEnabled = true,
    this.isAmountExceeded = false,
  });

  @override
  State<TransferFormSection> createState() => _TransferFormSectionState();
}

class _TransferFormSectionState extends State<TransferFormSection> {
  String _amountInWords = '';

  @override
  void initState() {
    super.initState();
    widget.amountController.addListener(_updateAmountWords);
  }

  @override
  void dispose() {
    widget.amountController.removeListener(_updateAmountWords);
    super.dispose();
  }

  void _updateAmountWords() {
    final text = widget.amountController.text.trim();
    // Parse the number out of the string (removing non-digits like $)
    final cleanNumText = text.replaceAll(RegExp(r'[^0-9]'), '');
    final number = int.tryParse(cleanNumText);

    if (number == null || number == 0) {
      setState(() {
        _amountInWords = '';
      });
      return;
    }

    final words = _convertToWords(number);
    setState(() {
      _amountInWords = '$words dollar${number > 1 ? 's' : ''}';
    });
  }

  String _convertToWords(int number) {
    final units = [
      "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
      "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen",
      "Seventeen", "Eighteen", "Nineteen"
    ];
    final tens = [
      "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"
    ];

    String convert(int n) {
      if (n < 20) return units[n];
      if (n < 100) return '${tens[n ~/ 10]}${n % 10 != 0 ? ' ${units[n % 10]}' : ''}';
      if (n < 1000) return '${units[n ~/ 100]} Hundred${n % 100 != 0 ? ' ${convert(n % 100)}' : ''}';
      if (n < 1000000) return '${convert(n ~/ 1000)} Thousand${n % 1000 != 0 ? ' ${convert(n % 1000)}' : ''}';
      return '${convert(n ~/ 1000000)} Million${n % 1000000 != 0 ? ' ${convert(n % 1000000)}' : ''}';
    }

    return convert(number);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: widget.nameController,
          hintText: 'Name',
          enabled: widget.isEnabled,
          onChanged: widget.onNameChanged,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: widget.cardController,
          hintText: 'Card number',
          enabled: widget.isEnabled,
          keyboardType: TextInputType.number,
          onChanged: widget.onCardChanged,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: widget.amountController,
          hintText: 'Amount',
          enabled: widget.isEnabled,
          keyboardType: TextInputType.number,
          onChanged: widget.onAmountChanged,
        ),
        if (widget.isAmountExceeded) ...[
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              'Amount exceeds available balance',
              style: TextStyle(
                color: AppColors.error,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        CustomTextField(
          controller: widget.contentController,
          hintText: 'Content',
          enabled: widget.isEnabled,
          onChanged: widget.onContentChanged,
        ),
        if (_amountInWords.isNotEmpty) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              _amountInWords.toLowerCase(),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
