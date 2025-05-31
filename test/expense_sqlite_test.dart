
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Expense {
  final int? id;
  final String title;
  final double amount;
  final String currency;
  final DateTime date;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.currency,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'currency': currency,
      'date': date.toIso8601String(),
    };
  }

  static Expense fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      currency: map['currency'],
      date: DateTime.parse(map['date']),
    );
  }
}

class DatabaseHelper {
  late Database _db;

  Future<void> initTestDb() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    _db = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE expenses (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          amount REAL,
          currency TEXT,
          date TEXT
        )
      ''');
    });
  }

  Future<int> insertExpense(Expense expense) async {
    return await _db.insert('expenses', expense.toMap());
  }

  Future<Expense?> getExpenseById(int id) async {
    final maps = await _db.query(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Expense.fromMap(maps.first);
    }
    return null;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late DatabaseHelper dbHelper;

  setUpAll(() async {
    dbHelper = DatabaseHelper();
    await dbHelper.initTestDb();
  });

  group('SQLite Expense Test', () {
    test('Should insert and retrieve expense', () async {
      final expense = Expense(
        title: 'Test Lunch',
        amount: 120.5,
        currency: 'EGP',
        date: DateTime.now(),
      );

      final id = await dbHelper.insertExpense(expense);
      final retrieved = await dbHelper.getExpenseById(id);

      expect(retrieved?.title, equals('Test Lunch'));
      expect(retrieved?.amount, equals(120.5));
      expect(retrieved?.currency, equals('EGP'));
    });
  });
}
