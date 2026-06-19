import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: onChanged,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      decoration: const InputDecoration(
        labelText: 'Kategori',
        prefixIcon: Icon(Icons.category_outlined),
      ),
    );
  }
}
