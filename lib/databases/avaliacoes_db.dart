import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SQLAvaliacoes {
  static Future<void> criaTabela(sql.Database database) async {
    await database.execute("""CREATE TABLE avaliacoes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        sincronizado INTEGER,
        avaliacaoDia TEXT,
        poucoDoDia TEXT,
        idUsuario INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<void> sincronizarComFirebase() async {
    // Verificar a conexão antes de sincronizar
    if (await checkInternetConnection()) {
      final db = await SQLAvaliacoes.db();

      // Obter registros não sincronizados
      final registrosNaoSincronizados = await db.query('avaliacoes', where: "sincronizado = ?", whereArgs: [0]);

      // Enviar registros para o Firebase
      for (var registro in registrosNaoSincronizados) {
        await db.update('avaliacoes', {'sincronizado': 1},
            where: "id = ?", whereArgs: [registro['id']]);
        await FirebaseFirestore.instance.collection('avaliacoes').add(registro);

        // Atualizar o campo 'sincronizado' localmente
      }
    }
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