abstract class AddExpenseEvent {}

class SubmitExpense extends AddExpenseEvent {
  final String category;
  final double amount;
  final String currency;
  final DateTime date;

  SubmitExpense({
    required this.category,
    required this.amount,
    required this.currency,
    required this.date,
  });
}
