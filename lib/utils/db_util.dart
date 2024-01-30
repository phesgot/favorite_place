import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

// Classe utilitária para operações de banco de dados.
class DbUtil {
  // Método estático para abrir ou criar o banco de dados SQLite.
  static Future<sql.Database> database() async {
    // Obtém o caminho do diretório onde o banco de dados será armazenado.
    final dbPath = await sql.getDatabasesPath();
    // Abre ou cria o banco de dados SQLite.
    return sql.openDatabase(
      path.join(dbPath, 'places.db'), // Caminho do banco de dados.
      onCreate: (db, version) {
        // Cria a tabela "places" no banco de dados quando ele é criado pela primeira vez.
        return db.execute(
          'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)',
        );
      },
      version: 1, // Versão do banco de dados.
    );
  }

  // Método estático para inserir dados em uma tabela do banco de dados.
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database(); // Obtém uma referência ao banco de dados.
    // Insere os dados na tabela especificada, substituindo se houver conflito.
    await db.insert(
      table, // Tabela onde os dados serão inseridos.
      data, // Dados a serem inseridos.
      conflictAlgorithm: sql.ConflictAlgorithm.replace, // Define a estratégia de conflito.
    );
  }

  // Método estático para obter dados de uma tabela do banco de dados.
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database(); // Obtém uma referência ao banco de dados.
    // Executa uma consulta na tabela especificada e retorna os resultados.
    return db.query(table);
  }
}
