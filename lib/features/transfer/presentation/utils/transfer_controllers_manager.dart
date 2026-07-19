import 'package:flutter/material.dart';
import '../cubit/transfer_state.dart';

class TransferControllersManager {
  final nameController = TextEditingController();
  final cardController = TextEditingController();
  final amountController = TextEditingController();
  final contentController = TextEditingController();

  void syncState(TransferState state) {
    if (state.name != nameController.text) {
      nameController.value = TextEditingValue(
        text: state.name,
        selection: TextSelection.fromPosition(
          TextPosition(offset: state.name.length),
        ),
      );
    }
    if (state.cardNumber != cardController.text) {
      cardController.value = TextEditingValue(
        text: state.cardNumber,
        selection: TextSelection.fromPosition(
          TextPosition(offset: state.cardNumber.length),
        ),
      );
    }
  }

  void dispose() {
    nameController.dispose();
    cardController.dispose();
    amountController.dispose();
    contentController.dispose();
  }
}
