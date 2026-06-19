import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import '../pages/home/home_page.dart';
import '../pages/report/report_page.dart';
import '../pages/splash/splash_page.dart';
import '../pages/transaction/transaction_form_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String transactionForm = '/transaction-form';
  static const String report = '/report';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case transactionForm:
        final tx = settings.arguments is TransactionModel
            ? settings.arguments as TransactionModel
            : null;
        return MaterialPageRoute(
          builder: (_) => TransactionFormPage(transaction: tx),
        );
      case report:
        return MaterialPageRoute(builder: (_) => const ReportPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route tidak ditemukan')),
          ),
        );
    }
  }
}
