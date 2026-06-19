import 'package:flutter/material.dart';

import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == 'income';
    final accentColor = isIncome ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: accentColor.withValues(alpha: 0.12),
            child: Icon(
              isIncome ? Icons.south_west : Icons.north_east,
              color: accentColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${transaction.category} • ${DateFormatter.short(transaction.date)}',
                  style: const TextStyle(color: Colors.grey),
                ),
                if (transaction.note.trim().isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    transaction.note,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isIncome ? '+' : '-'}${CurrencyFormatter.format(transaction.amount)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined),
                    tooltip: 'Edit',
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Hapus',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
