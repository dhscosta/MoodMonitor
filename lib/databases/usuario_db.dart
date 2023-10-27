import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLUsuarios {
  static Future<void> criaTabela(sql.Database database) async {
    await database.execute("""CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        senha TEXT,
        celEmail TEXT,
        dataNascimento TEXT,
        genero TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'usuarios.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criaTabela(database);
      },
    );
  }

  static Future<int> adicionarUsuario(String nome, String senha, String celEmail, String dataNascimento, String? genero) async {
    final db = await SQLUsuarios.db();

    final dados = {'nome': nome, 'senha': senha, 'celEmail': celEmail, 'dataNascimento': dataNascimento, 'genero': genero};
    final id = await db.insert('usuarios', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> listarUsuarios() async {
    final db = await SQLUsuarios.db();
    return db.query('usuarios', orderBy: "id DESC", limit: 1);
  }

  static Future<List<Map<String, dynamic>>> validaUsuario(String email, String senha) async {
    final db = await SQLUsuarios.db();
    return db.query('usuarios', where: "celEmail = ? AND senha = ?", whereArgs: [email, senha], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> recuperaUsuario(int id) async {
    final db = await SQLUsuarios.db();
    return db.query('usuarios', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> atualizarUsuario(
      int id, String nome, String senha, String celEmail, String dataNascimento, String? genero) async {
    final db = await SQLUsuarios.db();

    final dados = {
      'nome': nome,
      'senha': senha,
      'celEmail': celEmail,
      'dataNascimento': dataNascimento,
      'genero': genero,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('usuarios', dados, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deletarUsuario(int id) async {
    final db = await SQLUsuarios.db();
    try {
      await db.delete("usuarios", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Erro ao apagar o usuario: $err");
    }
  }
}