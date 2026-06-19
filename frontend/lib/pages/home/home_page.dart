import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/routes.dart';
import '../../models/transaction_model.dart';
import '../../providers/transaction_provider.dart';
import '../../shared/layouts/base_scaffold.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/error_message.dart';
import '../../shared/widgets/loading_indicator.dart';
import 'widgets/filter_section.dart';
import 'widgets/summary_card.dart';
import 'widgets/transaction_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TransactionProvider>().loadTransactions();
    });
  }

  Future<void> _confirmDelete(
    BuildContext context,
    TransactionModel transaction,
  ) async {
    final provider = context.read<TransactionProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus transaksi'),
        content: Text('Yakin ingin menghapus "${transaction.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await provider.deleteTransaction(transaction.id);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Transaksi berhasil dihapus'
                : provider.errorMessage ?? 'Gagal menghapus transaksi',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, _) {
        return BaseScaffold(
          title: 'Finance Tracker',
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.report),
              icon: const Icon(Icons.bar_chart_rounded),
              tooltip: 'Laporan',
            ),
          ],
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.transactionForm),
            icon: const Icon(Icons.add),
            label: const Text('Tambah'),
          ),
          child: provider.isLoading && provider.transactions.isEmpty
              ? const LoadingIndicator()
              : RefreshIndicator(
                  onRefresh: provider.loadTransactions,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      SummaryCard(
                        balance: provider.balance,
                        income: provider.totalIncome,
                        expense: provider.totalExpense,
                      ),
                      const SizedBox(height: 16),
                      FilterSection(
                        currentFilter: provider.selectedFilter,
                        onFilterChanged: provider.setFilter,
                        onSearchChanged: provider.setSearchQuery,
                      ),
                      const SizedBox(height: 16),
                      if (provider.errorMessage != null) ...[
                        ErrorMessage(message: provider.errorMessage!),
                        const SizedBox(height: 12),
                      ],
                      const Text(
                        'Daftar Transaksi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (provider.filteredTransactions.isEmpty)
                        const EmptyState(
                          title: 'Belum ada transaksi',
                          subtitle:
                              'Tambahkan pemasukan atau pengeluaran pertamamu.',
                        )
                      else
                        ...provider.filteredTransactions.map(
                          (transaction) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: TransactionCard(
                              transaction: transaction,
                              onEdit: () => Navigator.pushNamed(
                                context,
                                AppRoutes.transactionForm,
                                arguments: transaction,
                              ),
                              onDelete: () =>
                                  _confirmDelete(context, transaction),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
