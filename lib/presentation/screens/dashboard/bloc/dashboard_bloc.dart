import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/datasources/expense_database.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ExpenseDatabase _db = ExpenseDatabase.instance;

  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardData>((event, emit) async {
      emit(DashboardLoading());
      try {
        final expenses = await _db.getAllExpenses();
        final totalExpenses = expenses.fold<double>(0.0, (sum, e) => sum + e.convertedAmountUSD);
        const totalIncome = 1000.0;
        final totalBalance = totalIncome - totalExpenses;

        emit(DashboardLoaded(
          totalBalance: totalBalance,
          totalIncome: totalIncome,
          totalExpenses: totalExpenses,
          recentExpenses: expenses, // Limit to 3 recent transactions
        ));
      } catch (e) {
        emit(DashboardError("Failed to load dashboard data"));
      }
    });
  }
}
