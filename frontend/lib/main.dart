import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'core/network/api_client.dart';
import 'providers/transaction_provider.dart';
import 'repositories/transaction_repository.dart';
import 'services/transaction_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  Intl.defaultLocale = 'id_ID';

  final apiClient = ApiClient();
  final transactionService = TransactionService(apiClient);
  final transactionRepository = TransactionRepository(transactionService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(transactionRepository),
        ),
      ],
      child: const FinanceTrackerApp(),
    ),
  );
}
