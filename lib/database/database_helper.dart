import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        // Criação da tabela Nota
        await db.execute('''
          CREATE TABLE Nota(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            valor REAL
          )
        ''');

        // Criação da tabela Imagem
        await db.execute('''
          CREATE TABLE Imagem(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            srcPath TEXT,
            id_nota INTEGER,
            FOREIGN KEY (id_nota) REFERENCES Nota (id)
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE Nota ADD COLUMN valor REAL');
          await db.execute('ALTER TABLE Imagem ADD COLUMN srcPath TEXT');
        }
      },
    );
  }

  Future<void> printDatabasePath() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    print("Database path: $path");
  }

  // Métodos de CRUD para Nota
  Future<int> insertNota(Map<String, dynamic> nota) async {
    final db = await database;
    return await db.insert('Nota', nota);
  }

  Future<List<Map<String, dynamic>>> getNotas() async {
    final db = await database;
    return await db.query('Nota');
  }

  Future<int> deleteNota(int idNota) async {
    final db = await database;

    // Excluir imagens relacionadas à nota
    await db.delete(
      'Imagem',
      where: 'id_nota = ?',
      whereArgs: [idNota],
    );

    // Excluir a nota
    return await db.delete(
      'Nota',
      where: 'id = ?',
      whereArgs: [idNota],
    );
  }

  // Métodos de CRUD para Imagem
  Future<int> insertImagem(Map<String, dynamic> imagem) async {
    final db = await database;
    return await db.insert('Imagem', imagem);
  }

  Future<List<Map<String, dynamic>>> getImagensByNota(int idNota) async {
    final db = await database;
    return await db.query('Imagem', where: 'id_nota = ?', whereArgs: [idNota]);
  }
}
