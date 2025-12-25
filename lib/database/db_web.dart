
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common/sqlite_api.dart';
import '../models/transaction.dart' as model;

class DBHelper {
  static Database? _database;

  static void init() {
    // No global init needed if using factory directly
  }

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    // Check sqflite_common_ffi_web usage
    return await databaseFactoryFfiWeb.openDatabase(
      filePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _createDB,
      ),
    );
  }

  static Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        title TEXT,
        amount REAL,
        date TEXT,
        category TEXT
      )
    ''');
  }

  static Future<void> insertTransaction(model.Transaction transaction) async {
    final db = await database;
    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<model.Transaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions', orderBy: "date DESC");

    return List.generate(maps.length, (i) {
      return model.Transaction.fromMap(maps[i]);
    });
  }

  static Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
