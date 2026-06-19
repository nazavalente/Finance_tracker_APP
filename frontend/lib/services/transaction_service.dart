import '../core/constants/api_constants.dart';
import '../core/network/api_client.dart';
import '../models/transaction_model.dart';

class TransactionService {
  final ApiClient apiClient;

  TransactionService(this.apiClient);

  Future<List<TransactionModel>> fetchTransactions() async {
    final response = await apiClient.get(ApiConstants.transactions);

    if (response is List) {
      return response
          .map(
            (item) => TransactionModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    }

    throw Exception('Format data transaksi tidak sesuai');
  }

  Future<void> createTransaction(TransactionModel transaction) async {
    await apiClient.post(ApiConstants.transactions, transaction.toJson());
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await apiClient.put(
      '${ApiConstants.transactions}/${transaction.id}',
      transaction.toJson(),
    );
  }

  Future<void> deleteTransaction(String id) async {
    await apiClient.delete('${ApiConstants.transactions}/$id');
  }
}
