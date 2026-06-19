import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  final String currentFilter;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<String> onSearchChanged;

  const FilterSection({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = const [
      {'label': 'Semua', 'value': 'all'},
      {'label': 'Income', 'value': 'income'},
      {'label': 'Expense', 'value': 'expense'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Cari judul, kategori, atau catatan...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((item) {
              final isSelected = currentFilter == item['value'];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(item['label']!),
                  selected: isSelected,
                  onSelected: (_) => onFilterChanged(item['value']!),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
