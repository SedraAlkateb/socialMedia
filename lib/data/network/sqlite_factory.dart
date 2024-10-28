import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  Batch? batch;
  factory DatabaseHelper() {
    return _instance;
  }
  DatabaseHelper._internal();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'task_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user (
    userId TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    image TEXT NOT NULL 
    );
    ''');
    await db.execute('''
      CREATE TABLE post (
    postId TEXT PRIMARY KEY ,
    desc TEXT NOT NULL,
    favorite INTEGER NOT NULL,
    commentCount INTEGER NOT NULL,
    timestamp DATETIME NOT NULL,
    userId TEXT NOT NULL,
    FOREIGN KEY (userId) REFERENCES user(userId)
    );
   ''');

    await db.execute('''
      CREATE TABLE post_image (
      id INTEGER PRIMARY  KEY AUTOINCREMENT,
      image TEXT NOT NULL,
      postId TEXT NOT NULL,
      FOREIGN KEY (postId) REFERENCES  post(postId)
    );
    ''');
    await db.execute('''
      CREATE TABLE comment (
    commentId INTEGER PRIMARY KEY,
    content TEXT NOT NULL,
    timestamp DATETIME NOT NULL,
    userId TEXT NOT NULL,
    postId TEXT NOT NULL,
    FOREIGN KEY (postId) REFERENCES  post(postId),
    FOREIGN KEY (userId) REFERENCES  user(userId)

    );
    ''');
    await db.execute('''
      CREATE TABLE story (
    storyId TEXT PRIMARY KEY ,
    userId TEXT NOT NULL,
    FOREIGN KEY (userId) REFERENCES user(userId)
    );
   ''');
    await db.execute('''
      CREATE TABLE story_image (
      id INTEGER PRIMARY  KEY AUTOINCREMENT,
    image TEXT NOT NULL,
    storyId TEXT NOT NULL,
    FOREIGN KEY (storyId) REFERENCES  story(storyId)
    );
    ''');
  }
}
