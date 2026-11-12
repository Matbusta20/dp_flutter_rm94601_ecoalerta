import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/ocorrencia_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('ecoalerta.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ocorrencias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        categoria TEXT NOT NULL,
        bairro TEXT NOT NULL,
        descricao TEXT NOT NULL,
        urgente INTEGER NOT NULL
      )
    ''');

    await db.insert('ocorrencias', {
      'titulo': 'Buraco profundo na via',
      'categoria': 'Infraestrutura',
      'bairro': 'Aclimação',
      'descricao': 'Cratera próxima ao ponto de ônibus oferecendo risco aos carros.',
      'urgente': 1,
    });
    await db.insert('ocorrencias', {
      'titulo': 'Poste com luz apagada',
      'categoria': 'Iluminação',
      'bairro': 'Vila Mariana',
      'descricao': 'Rua totalmente escura no período noturno há 3 dias.',
      'urgente': 0,
    });
  }

  Future<int> insert(Ocorrencia ocorrencia) async {
    final db = await instance.database;
    return await db.insert('ocorrencias', ocorrencia.toMap());
  }

  Future<List<Ocorrencia>> getAll() async {
    final db = await instance.database;
    final result = await db.query('ocorrencias', orderBy: 'id DESC');
    return result.map((json) => Ocorrencia.fromMap(json)).toList();
  }

  Future<int> update(Ocorrencia ocorrencia) async {
    final db = await instance.database;
    return await db.update(
      'ocorrencias',
      ocorrencia.toMap(),
      where: 'id = ?',
      whereArgs: [ocorrencia.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'ocorrencias',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}