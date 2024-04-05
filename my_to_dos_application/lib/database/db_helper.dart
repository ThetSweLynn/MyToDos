import 'package:my_to_dos_application/models/reminder.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'reminders';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'reminders.db';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("creating a new one");
        db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "task STRING, "
          "note TEXT, "
          "date STRING, "
          "time STRING, "
          "color INTEGER, "
          "isPinned INTEGER, "
          "isCompleted INTEGER)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Reminder? reminder) async {
    print("insert function called");
    return await _db?.insert(_tableName, reminder!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _db!.query(
      _tableName,
      where: 'isCompleted = ?',
      whereArgs: [0],
    );
  }

  static delete(Reminder reminder) async {
    return await _db!
        .delete(_tableName, where: "id = ?", whereArgs: [reminder.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
    UPDATE reminders
    SET isCompleted = 1
    WHERE id = $id''');
  }

  static Future<List<Map<String, dynamic>>> getCompletedTasks() async {
    print("getCompletedTasks function called");
    return await _db!.query(
      _tableName,
      where: 'isCompleted = ?',
      whereArgs: [1],
    );
  }
}
