import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense_model.dart';

class ExpenseDatabase {
  static final ExpenseDatabase instance = ExpenseDatabase._init();
  static Database? _database;

  ExpenseDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE expenses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      category TEXT NOT NULL,
      originalAmount REAL NOT NULL,
      currency TEXT NOT NULL,
      convertedAmountUSD REAL NOT NULL,
      date TEXT NOT NULL
    )
    ''');
  }

  Future<ExpenseModel> insertExpense(ExpenseModel expense) async {
    final db = await instance.database;
    final id = await db.insert('expenses', expense.toMap());
    return expense.copyWith(id: id);
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    final db = await instance.database;
    final result = await db.query('expenses', orderBy: 'date DESC');
    return result.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
