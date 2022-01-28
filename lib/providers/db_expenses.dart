

import 'package:exp_app/models/expenses_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBExpenses {
  static Database? _database;
  static final DBExpenses db = DBExpenses._();
  DBExpenses._();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'ExpensesDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''CREATE TABLE Expenses (
            id INTEGER PRIMARY KEY, 
            link INTEGER, 
            year INTEGER, 
            month INTEGER,
            day INTEGER,
            comment TEXT,
            expense DOUBLE
          )'''
        );
        await db.execute(
          '''CREATE TABLE Entries (
            id INTEGER PRIMARY KEY,
            year INTEGER, 
            month INTEGER,
            day INTEGER,
            comment TEXT,
            entries DOUBLE
          )'''
        );
      }
    );
  }

  addExpense(ExpensesModel exp) async {
    final db = await database;
    final response = await db.insert('Expenses', exp.toJson());
    return response;
  }

  Future<List<ExpensesModel>> getExpenseByDate(int month, int year) async {
    final db = await database;
    final response = await db.query('Expenses', where: 'month = ? and year = ?',
      whereArgs: [month, year] );
    List<ExpensesModel> eList = response.isNotEmpty
      ? response.map((e) => ExpensesModel.fromJson(e)).toList()
      : [];
    return eList;
  }

  Future<int> updateExpenses(ExpensesModel exp) async {
    final db = await database;
    final response = db.update('Expenses', exp.toJson(), 
     where: 'id = ?', whereArgs: [exp.id] );
    return response;
  }

  Future<int> deleteExpenses(int id) async {
    final db = await database;
    final response = db.delete('Expenses', where: 'id = ?', whereArgs: [id]);
    return response;
  }
}