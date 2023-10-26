import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLAvaliacoes {
  static Future<void> criaTabela(sql.Database database) async {
    await database.execute("""CREATE TABLE avaliacoes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        avaliacaoDia TEXT,
        poucoDoDia TEXT,
        idUsuario INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'avaliacoes.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criaTabela(database);
      },
    );
  }

  static Future<int> adicionarAvaliacao(String avaliacaoDia, String poucoDoDia, int idUsuario) async {
    final db = await SQLAvaliacoes.db();

    final dados = {'avaliacaoDia': avaliacaoDia, 'poucoDoDia': poucoDoDia, 'idUsuario': idUsuario};
    final id = await db.insert('avaliacoes', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> listarAvaliacoes() async {
    final db = await SQLAvaliacoes.db();
    return db.query('avaliacoes', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> recuperarAvaliacoesDoUsuario(int idUsuario) async {
    final db = await SQLAvaliacoes.db();
    return db.query('avaliacoes', where: "idUsuario = ?", whereArgs: [idUsuario]);
  }

  static Future<List<Map<String, dynamic>>> recuperarAvaliacao(int id) async {
    final db = await SQLAvaliacoes.db();
    return db.query('avaliacoes', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> atualizarAvaliacao(
      int id, String avaliacaoDia, String poucoDoDia, int idUsuario) async {
    final db = await SQLAvaliacoes.db();

    final dados = {
      'avaliacaoDia': avaliacaoDia,
      'poucoDoDia': poucoDoDia,
      'idUsuario': idUsuario,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('avaliacoes', dados, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deletarAvaliacao(int id) async {
    final db = await SQLAvaliacoes.db();
    try {
      await db.delete("avaliacoes", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Erro ao apagar o avaliacao: $err");
    }
  }
}