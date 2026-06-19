import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/currency_formatter.dart';
import '../../providers/transaction_provider.dart';
import '../../shared/layouts/base_scaffold.dart';
import '../../shared/widgets/empty_state.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  Map<String, double> _buildCategoryExpenseMap(TransactionProvider provider) {
    final Map<String, double> result = {};

    for (final transaction in provider.transactions.where(
      (item) => item.type == 'expense',
    )) {
      result.update(
        transaction.category,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final categoryMap = _buildCategoryExpenseMap(provider);
    final sortedEntries = categoryMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return BaseScaffold(
      title: 'Laporan Keuangan',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ringkasan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _ReportRow(
                    label: 'Total Income',
                    value: CurrencyFormatter.format(provider.totalIncome),
                  ),
                  _ReportRow(
                    label: 'Total Expense',
                    value: CurrencyFormatter.format(provider.totalExpense),
                  ),
                  _ReportRow(
                    label: 'Saldo',
                    value: CurrencyFormatter.format(provider.balance),
                    isBold: true,
                  ),
                  _ReportRow(
                    label: 'Jumlah Transaksi',
                    value: provider.transactions.length.toString(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pengeluaran per Kategori',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (sortedEntries.isEmpty)
                    const EmptyState(
                      title: 'Belum ada data pengeluaran',
                      subtitle:
                          'Tambahkan transaksi expense untuk melihat rekap kategori.',
                      icon: Icons.pie_chart_outline,
                    )
                  else
                    ...sortedEntries.map((entry) {
                      final percentage = provider.totalExpense > 0
                          ? (entry.value / provider.totalExpense)
                          : 0.0;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    entry.key,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(CurrencyFormatter.format(entry.value)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(value: percentage),
                            const SizedBox(height: 4),
                            Text(
                              '${(percentage * 100).toStringAsFixed(1)}% dari total expense',
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _ReportRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
      fontSize: isBold ? 16 : 14,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
