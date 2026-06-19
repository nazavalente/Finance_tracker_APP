import 'package:flutter/material.dart';

import '../../../core/utils/validators.dart';
import '../../../shared/widgets/custom_text_field.dart';

class AmountInput extends StatelessWidget {
  final TextEditingController controller;

  const AmountInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: 'Nominal',
      hintText: 'Contoh: 25000',
      keyboardType: TextInputType.number,
      validator: Validators.amount,
      prefixIcon: const Icon(Icons.payments_outlined),
    );
  }
}
