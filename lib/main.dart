import 'package:expense_tracker/presentation/screens/add_expense/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
      routes: {
        '/add-expense': (context) => const AddExpenseScreen(),
      },
    );
  }
}

