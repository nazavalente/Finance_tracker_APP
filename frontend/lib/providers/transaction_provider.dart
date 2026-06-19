import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import '../repositories/transaction_repository.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository repository;

  TransactionProvider(this.repository);

  final List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedFilter = 'all';
  String _searchQuery = '';

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedFilter => _selectedFilter;
  String get searchQuery => _searchQuery;

  List<TransactionModel> get filteredTransactions {
    Iterable<TransactionModel> items = _transactions;

    if (_selectedFilter != 'all') {
      items = items.where((item) => item.type == _selectedFilter);
    }

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      items = items.where(
        (item) =>
            item.title.toLowerCase().contains(query) ||
            item.category.toLowerCase().contains(query) ||
            item.note.toLowerCase().contains(query),
      );
    }

    return items.toList();
  }

  double get totalIncome => _transactions
      .where((item) => item.type == 'income')
      .fold(0, (sum, item) => sum + item.amount);

  double get totalExpense => _transactions
      .where((item) => item.type == 'expense')
      .fold(0, (sum, item) => sum + item.amount);

  double get balance => totalIncome - totalExpense;

  Future<void> loadTransactions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.getTransactions();
      _transactions
        ..clear()
        ..addAll(result);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addTransaction(TransactionModel transaction) async {
    try {
      await repository.addTransaction(transaction);
      await loadTransactions();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTransaction(TransactionModel transaction) async {
    try {
      await repository.updateTransaction(transaction);
      await loadTransactions();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTransaction(String id) async {
    try {
      await repository.deleteTransaction(id);
      await loadTransactions();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
