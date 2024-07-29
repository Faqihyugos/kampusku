import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../models/student.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'mahasiswa.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomor TEXT,
        name TEXT,
        tanggalLahir TEXT,
        jenisKelamin TEXT,
        alamat TEXT
      )
    ''');

    // Hash password
    var password = 'Asdf1234';
    var bytes = utf8.encode(password); // Convert password to bytes
    var hashedPassword = sha256.convert(bytes).toString();

    // Insert initial user
    await db.insert('users', {
      'username': 'admin',
      'password': hashedPassword,
    });
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient.insert('users', user);
  }

  Future<int> insertStudent(Student student) async {
    var dbClient = await db;
    return await dbClient.insert('students', student.toMap());
  }

  Future<int> updateStudent(Student student) async {
    var dbClient = await db;
    return await dbClient.update('students', student.toMap(),
        where: 'id = ?', whereArgs: [student.id]);
  }

  Future<int> deleteStudent(int id) async {
    var dbClient = await db;
    return await dbClient.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Student>> getStudents() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query('students');
    return maps.map((student) => Student.fromMap(student)).toList();
  }

  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    var dbClient = await db;

    // Hash the password
    var bytes = utf8.encode(password);
    var hashedPassword = sha256.convert(bytes).toString();

    List<Map<String, dynamic>> maps = await dbClient.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, hashedPassword]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
}
