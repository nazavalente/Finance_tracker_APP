import 'package:flutter/material.dart';

class TypeSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const TypeSelector({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Text('Income'),
            selected: value == 'income',
            onSelected: (_) => onChanged('income'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ChoiceChip(
            label: const Text('Expense'),
            selected: value == 'expense',
            onSelected: (_) => onChanged('expense'),
          ),
        ),
      ],
    );
  }
}
