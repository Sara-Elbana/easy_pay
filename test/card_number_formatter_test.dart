import 'package:flutter_test/flutter_test.dart';
import 'package:easy_pay_app/core/utils/card_number_formatter.dart';

void main() {
  test('formatCardNumber formatting and length truncation', () {
    expect(formatCardNumber(''), '');
    expect(formatCardNumber('12345'), '1234 5');
    expect(formatCardNumber('1234567812345678'), '1234 5678 1234 5678');
    expect(formatCardNumber('123456781234567890'), '1234 5678 1234 5678');
    expect(formatCardNumber('1234-5678-1234-5678'), '1234 5678 1234 5678');
  });
}
