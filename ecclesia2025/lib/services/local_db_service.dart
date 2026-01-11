import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDbService {
  static final LocalDbService _instance = LocalDbService._internal();
  factory LocalDbService() => _instance;
  LocalDbService._internal();

  Database ? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb;
    return _database!;
  }

  Future<Database> get _initDb async {
    String path = join(await getDatabasesPath(), 'ecclesia.db');
    return await openDatabase(path, version:1, onCreate: _onCreateDb);

  }

  Future<void> _onCreateDb(Database db, int version) async {
    // Diocese Table
    await db.execute('''
      CREATE TABLE diocese(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        region TEXT NOT NULL,
        description TEXT
      )
    ''');

    // Vicariate Table
    await db.execute('''
      CREATE TABLE vicariate(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        diocese_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        FOREIGN KEY (diocese_id) REFERENCES diocese(id) ON DELETE CASCADE
      )
    ''');

    // Church Table
    await db.execute('''
      CREATE TABLE church(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        vicariate_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        latitude REAL,
        longitude REAL,
        FOREIGN KEY (vicariate_id) REFERENCES vicariate(id) ON DELETE CASCADE
      )
    ''');

    // Mass Schedule Table
    await db.execute('''
      CREATE TABLE mass_schedule(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        church_id INTEGER NOT NULL,
        day TEXT NOT NULL,
        time TEXT NOT NULL,
        language TEXT,
        FOREIGN KEY (church_id) REFERENCES church(id) ON DELETE CASCADE
      )
    ''');

    // Confession Schedule Table
    await db.execute('''
      CREATE TABLE confession_schedule(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        church_id INTEGER NOT NULL,
        day TEXT NOT NULL,
        time TEXT NOT NULL,
        FOREIGN KEY (church_id) REFERENCES church(id) ON DELETE CASCADE
      )
    ''');
  }
}