import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SQLAvaliacoes {
  static Future<void> criaTabela(sql.Database database) async {
    await database.execute("""CREATE TABLE avaliacoes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        sincronizado INTEGER,
        avaliacaoDia INTEGER,
        poucoDoDia TEXT,
        idUsuario INTEGER,
        createdAt TEXT
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
      final registrosNaoSincronizados = await db.query(
        'avaliacoes',
        where: "sincronizado = ?",
        whereArgs: [0],
      );

      // Enviar registros para o Firebase
      for (var registro in registrosNaoSincronizados) {
        print("entrou aqui4");
        // Atualizar o campo 'sincronizado' localmente
        await db.update(
          'avaliacoes',
          {'sincronizado': 1},
          where: "id = ?",
          whereArgs: [registro['id']],
        );

        // Criar uma cópia mutável do mapa antes de modificá-lo
        Map<String, dynamic> registroModificavel = Map.from(registro);
        registroModificavel['sincronizado'] = 1;

        await FirebaseFirestore.instance
            .collection('avaliacoes')
            .add(registroModificavel);
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

  static Future<int> adicionarAvaliacao(int avaliacaoDia, String poucoDoDia,
      int idUsuario, DateTime criacao) async {
    final db = await SQLAvaliacoes.db();

    final dados = {
      'avaliacaoDia': avaliacaoDia,
      'poucoDoDia': poucoDoDia,
      'idUsuario': idUsuario,
      'createdAt': DateFormat('dd/MM/yyyy').format(criacao),
      'sincronizado': 0
    };
    final id = await db.insert('avaliacoes', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> listarAvaliacoes() async {
    final db = await SQLAvaliacoes.db();
    return db.query('avaliacoes', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> recuperarAvaliacoesDoUsuario(
      int idUsuario) async {
    final db = await SQLAvaliacoes.db();
    return db
        .query('avaliacoes', where: "idUsuario = ?", whereArgs: [idUsuario]);
  }

  static Future<List<Map<String, dynamic>>> recuperarAvaliacao(
      int idUsuario, String data) async {
    final db = await SQLAvaliacoes.db();
    return db.query('avaliacoes',
        where: "idUsuario = ? AND createdAt = ?",
        whereArgs: [idUsuario, data],
        limit: 1);
  }

  static Future<int> atualizarAvaliacao(
      int id, int avaliacaoDia, String poucoDoDia) async {
    final db = await SQLAvaliacoes.db();

    final dados = {'avaliacaoDia': avaliacaoDia, 'poucoDoDia': poucoDoDia};

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
