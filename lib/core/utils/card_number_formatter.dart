import 'package:flutter/services.dart';

String formatCardNumber(String value) {
  final clean = value.replaceAll(RegExp(r'\D'), '');
  final truncated = clean.length > 16 ? clean.substring(0, 16) : clean;
  final buffer = StringBuffer();
  for (int i = 0; i < truncated.length; i++) {
    if (i > 0 && i % 4 == 0) {
      buffer.write(' ');
    }
    buffer.write(truncated[i]);
  }
  return buffer.toString();
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    
    if (text.isEmpty) {
      return newValue;
    }

    final formattedText = formatCardNumber(text);
    
    // Calculate cursor position dynamically
    int cursorPosition = newValue.selection.end;
    
    // Count how many non-digit characters (spaces) were added before the cursor
    // relative to the digits-only version.
    int digitsBeforeCursor = text.substring(0, cursorPosition).replaceAll(RegExp(r'\D'), '').length;
    if (digitsBeforeCursor > 16) {
      digitsBeforeCursor = 16;
    }
    
    // Based on digits-only count, how many spaces are needed?
    int spacesBeforeCursor = 0;
    if (digitsBeforeCursor > 0) {
      spacesBeforeCursor = (digitsBeforeCursor - 1) ~/ 4;
    }
    
    int newCursorPosition = digitsBeforeCursor + spacesBeforeCursor;
    
    if (newCursorPosition > formattedText.length) {
      newCursorPosition = formattedText.length;
    }
    if (newCursorPosition < 0) {
      newCursorPosition = 0;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }
}
