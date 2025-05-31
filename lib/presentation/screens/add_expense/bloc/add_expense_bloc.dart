import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/datasources/currency_service.dart';
import '../../../../data/datasources/expense_database.dart';
import '../../../../data/models/expense_model.dart';
import 'add_expense_event.dart';
import 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final ExpenseDatabase _db = ExpenseDatabase.instance;
  final CurrencyService _currencyService = CurrencyService();

  AddExpenseBloc() : super(AddExpenseInitial()) {
    on<SubmitExpense>((event, emit) async {
      emit(AddExpenseLoading());
      try {
        final usdAmount = await _currencyService.convertToUSD(
          event.currency,
          event.amount,
        );

        final expense = ExpenseModel(
          category: event.category,
          originalAmount: event.amount,
          currency: event.currency,
          convertedAmountUSD: usdAmount,
          date: event.date,
        );

        await _db.insertExpense(expense);
        emit(AddExpenseSuccess());
      } catch (e) {
        emit(AddExpenseFailure("Failed to add expense"));
      }
    });
  }
}
