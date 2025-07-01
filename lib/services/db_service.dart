import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DBService {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            isHighPriority INTEGER
          )
        ''');
      },
    );
  }

  /// Insert a new task
  Future<void> insertTask(Task task) async {
    final dbClient = await db;
    await dbClient.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all tasks
  Future<List<Task>> getTasks() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('tasks');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  /// Update a task
  Future<int> updateTask(Task task) async {
    final dbClient = await db;
    return await dbClient.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  /// Delete a task
  Future<int> deleteTask(int id) async {
    final dbClient = await db;
    return await dbClient.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
