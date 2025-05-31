import '../../../../data/models/expense_model.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final double totalBalance;
  final double totalIncome;
  final double totalExpenses;
  final List<ExpenseModel> recentExpenses;

  DashboardLoaded({
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpenses,
    required this.recentExpenses,
  });
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}
