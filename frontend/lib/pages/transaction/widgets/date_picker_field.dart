import 'package:flutter/material.dart';

import '../../../core/utils/date_formatter.dart';

class DatePickerField extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onTap;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Tanggal',
          prefixIcon: Icon(Icons.calendar_today_outlined),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(DateFormatter.full(selectedDate)),
        ),
      ),
    );
  }
}
