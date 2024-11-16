import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_mobile/domian/entiy/task.dart';

class TaskRepository {
  TaskRepository._privatrConstructor();
  static final TaskRepository instance = TaskRepository._privatrConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tm.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE task(
        id INTEGER PRIMARY KEY,
        taskName TEXT,
        taskType, TEXT,
        details TEXT,
        status TEXT,
        dateTimeCreated TEXT,
        dateTimeDue TEXT,
        dateTimeAssigned TEXT,
        taskIdentifier TEXT,
        dateTimeClosed TEXT
      )
 ''');
  }

  Future<int> insertTask(Task task) async {
    Database db = await instance.database;
    return await db.insert('task', task.toMap());
  }

  Future<int> updateTask(Task task) async {
    Database db = await instance.database;
    return await db
        .update('task', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<List<Task>> getTasks() async {
    Database db = await instance.database;
    var tasks = await db.query('task', orderBy: 'id');
    List<Task> taskList =
        tasks.isNotEmpty ? tasks.map((e) => Task.fromMap(e)).toList() : [];
    return taskList;
  }

  Future<List<Task>> getTaskByTaskType(String taskType) async {
    Database db = await instance.database;
    var tasks = await db.query('task',
        where: 'taskType = ?', whereArgs: [taskType], orderBy: 'id');
    List<Task> taskList =
        tasks.isNotEmpty ? tasks.map((e) => Task.fromMap(e)).toList() : [];
    return taskList;
  }

  Future<int> removeTask(int id) async {
    Database db = await instance.database;
    return await db.delete('task', where: 'id = ?', whereArgs: [id]);
  }
}
