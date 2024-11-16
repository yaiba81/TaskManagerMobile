import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_mobile/domian/entiy/evidence.dart';

class EvidenceRepository {
  EvidenceRepository._privatrConstructor();
  static final EvidenceRepository instance =
      EvidenceRepository._privatrConstructor();

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
      CREATE TABLE evidence(
        id INTEGER PRIMARY KEY,
        taskIdentifier TEXT,
        evidenceString, TEXT,
        evidenceDescription TEXT,
        dateTimeCreated TEXT
      )
 ''');
  }

  Future<int> insertEvidence(Evidence evidence) async {
    Database db = await instance.database;
    return await db.insert('evidence', evidence.toMap());
  }

  Future<int> updateEvidence(Evidence evidence) async {
    Database db = await instance.database;
    return await db.update('evidence', evidence.toMap(),
        where: 'id = ?', whereArgs: [evidence.id]);
  }

  Future<List<Evidence>> getEvidences() async {
    Database db = await instance.database;
    var evidences = await db.query('evidence', orderBy: 'id');
    List<Evidence> evidenceList = evidences.isNotEmpty
        ? evidences.map((e) => Evidence.fromMap(e)).toList()
        : [];
    return evidenceList;
  }

  Future<List<Evidence>> getEvidenceByTaskIdentifier(
      String taskIdentifier) async {
    Database db = await instance.database;
    var evidences = await db.query('evidence',
        where: 'taskIdentifier = ?',
        whereArgs: [taskIdentifier],
        orderBy: 'id');
    List<Evidence> evidenceList = evidences.isNotEmpty
        ? evidences.map((e) => Evidence.fromMap(e)).toList()
        : [];
    return evidenceList;
  }

  Future<int> removeEvidence(int id) async {
    Database db = await instance.database;
    return await db.delete('evidence', where: 'id = ?', whereArgs: [id]);
  }
}
