class ExpenseModel {
  final int? id;
  final String category;
  final double originalAmount;
  final String currency;
  final double convertedAmountUSD;
  final DateTime date;

  ExpenseModel({
    this.id,
    required this.category,
    required this.originalAmount,
    required this.currency,
    required this.convertedAmountUSD,
    required this.date,
  });

  ExpenseModel copyWith({int? id}) {
    return ExpenseModel(
      id: id ?? this.id,
      category: category,
      originalAmount: originalAmount,
      currency: currency,
      convertedAmountUSD: convertedAmountUSD,
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'originalAmount': originalAmount,
      'currency': currency,
      'convertedAmountUSD': convertedAmountUSD,
      'date': date.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      category: map['category'],
      originalAmount: map['originalAmount'],
      currency: map['currency'],
      convertedAmountUSD: map['convertedAmountUSD'],
      date: DateTime.parse(map['date']),
    );
  }
}
