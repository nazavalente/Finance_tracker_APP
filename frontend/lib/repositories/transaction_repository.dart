import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class TransactionRepository {
  final TransactionService service;

  TransactionRepository(this.service);

  Future<List<TransactionModel>> getTransactions() {
    return service.fetchTransactions();
  }

  Future<void> addTransaction(TransactionModel transaction) {
    return service.createTransaction(transaction);
  }

  Future<void> updateTransaction(TransactionModel transaction) {
    return service.updateTransaction(transaction);
  }

  Future<void> deleteTransaction(String id) {
    return service.deleteTransaction(id);
  }
}
