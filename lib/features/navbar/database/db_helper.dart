import 'package:ecomerce_app/features/feature.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static final int _version = 3;
  static final String _tableName = 'tasks';

  static Future<void> initialDB() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}tasks.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        print('Create New...');
        return db.execute("CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title TEXT, "
            "note TEXT, "
            "data TEXT, "
            "startTime TEXT, "
            "endTime TEXT, "
            "remind INTEGER, "
            "repeat TEXT, "
            "color INTEGER, "
            "isComplete INTEGER DEFAULT 0)");
      }, onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < newVersion) {
          print('Upgrading database from $oldVersion to $newVersion');
          db.execute("ALTER TABLE $_tableName ADD COLUMN isComplete INTEGER");
        }
      });
    } catch (e) {
      print("errorD$e");
    }
  }

  static Future<int> insert(TaskModel? task) async {
    if (_db == null) {
      print('Database not initialized!');
      return -1; // Handle error gracefully
    }
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query name call');
    return await _db!.query(_tableName);
  }

  static delete(TaskModel task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isComplete = ?
    WHERE id = ?
    ''', [1, id]);
  }
}
