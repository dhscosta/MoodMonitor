import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLAvaliacoes {
  static Future<void> criaTabela(sql.Database database) async {
    await database.execute("""CREATE TABLE avaliacoes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        avaliacaoDia INTEGER,
        poucoDoDia TEXT,
        idUsuario INTEGER,
        createdAt TEXT
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

  static Future<int> adicionarAvaliacao(int avaliacaoDia, String poucoDoDia, int idUsuario, DateTime criacao) async {
    final db = await SQLAvaliacoes.db();

    final dados = {'avaliacaoDia': avaliacaoDia, 'poucoDoDia': poucoDoDia, 'idUsuario': idUsuario, 'createdAt': DateFormat('dd/MM/yyyy').format(criacao)};
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

  static Future<List<Map<String, dynamic>>> recuperarAvaliacao(int idUsuario, String data) async {
    final db = await SQLAvaliacoes.db();
    return db.query('avaliacoes', where: "idUsuario = ? AND createdAt = ?", whereArgs: [idUsuario, data], limit: 1);
  }

  static Future<int> atualizarAvaliacao(
      int id, int avaliacaoDia, String poucoDoDia) async {
    final db = await SQLAvaliacoes.db();

    final dados = {
      'avaliacaoDia': avaliacaoDia,
      'poucoDoDia': poucoDoDia
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