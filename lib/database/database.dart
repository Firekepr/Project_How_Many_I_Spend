import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'database-tables.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _dataBase;
  Future<Database> get database async => _dataBase ??= await _initDatabase(false);

  Future<Database> _initDatabase(bool restart) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'how_many_spend.db');

    Database db = await openDatabase(
      path,
      version: 11,
      onCreate: _onCreate,
      readOnly: false,
    );

    return db;
  }

  Future _onCreate(Database db, int versions) async {
    await _createTables(db);
  }

  Future<void> _createTables(Database db) async {
    List<String> tables = [
      DataBaseTables.calendarEvents,
      DataBaseTables.systemConfiguration,
    ];

    try {
      for (var table in tables) {
        db.execute(table);
      }
    } catch (e) {
      log('Erro ao criar tabelas: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> getSQLSelect(String sql, [List<dynamic>? parameters]) async {
    Database db = await database;
    return await db.rawQuery(sql, parameters);
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    return _dataBase!.insert(table, values);
  }

  Future<int> update(
      String table, Map<String, Object?> values, String where, var id) async {
    return _dataBase!.update(table, values, where: where, whereArgs: [id]);
  }

  Future<int> delete(String sql) async {
    Database db = await database;
    return await db.rawDelete(sql);
  }

  Future<void> resetTables() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'how_many_spend.db');

    Database db = await database;

    await deleteDatabase(path);

    if (db.isOpen) {
      _dataBase = null;
      await db.close();
    }
  }
}
