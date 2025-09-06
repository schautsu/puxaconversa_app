import 'package:puxaconversa_app/data/models/question_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'question_data.dart';

class DatabaseService {
  // Adoção de Singleton para garantir uma única instância da classe e
  // possiblitar o acesso global a ela, controlando o acesso ao banco de dados.
  DatabaseService._();
  static final DatabaseService instance = DatabaseService._();
  // Instanciação do banco de dados e seu getter.
  static Database? _database;
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'puxaconversa.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
    await _populateData(db);
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE category(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE question(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        category INTEGER NOT NULL REFERENCES category
      )
    ''');
  }

  Future<void> _populateData(Database db) async {
    Batch multipleInserts = db.batch();
    // questionData do arquivo question_data.dart
    for (String categoryName in questionData.keys) {
      int categoryId = await db.insert('category', {'name': categoryName});

      // Asseguramos que o retorno não é nulo (já que a linguagem assume que pode ser).
      List<String> questions = questionData[categoryName]!;
      // Serão inseridas todas as perguntas no BD com Batch
      // É melhor em desempenho ao executar inserções em uma única transação
      for (String questionContent in questions) {
        multipleInserts.insert('question', {
          'content': questionContent,
          'category': categoryId,
        });
      }
    }
    await multipleInserts.commit(noResult: true);
  }

  // Retorna a lista de categorias existentes (para a tela de seleção de categorias)
  Future<List<Category>> getCategories() async {
    final db = await database;
    final List<Map<String, Object?>> categoryMaps = await db.query(
      'category',
      orderBy: 'name',
    );

    return [
      for (final {'id': id as int, 'name': name as String} in categoryMaps)
        Category(id: id, name: name),
    ];
  }

  // Retorna uma lista de perguntas de dadas categorias
  Future<List<Question>> getQuestions(List<int> categoryIds) async {
    final db = await database;
    // Constrói uma string com o número de parâmetros a serem informados (?) na query
    String catParameters = List.filled(categoryIds.length, '?').join(',');
    // SELECT * FROM question WHERE category IN (?,?,...), onde cada ? será substituído por um id
    final List<Map<String, Object?>> questionMaps = await db.query(
      'question',
      where: 'category IN ($catParameters)',
      whereArgs: categoryIds,
    );

    return [
      for (final {
            'id': id as int,
            'content': content as String,
            'category': category as int,
          }
          in questionMaps)
        Question(id: id, content: content, category: category),
    ];
  }
}
