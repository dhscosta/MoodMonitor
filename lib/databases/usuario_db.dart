import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SQLUsuarios {
  static Future<void> criaTabela(sql.Database database) async {
    await database.execute("""CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        sincronizado INTEGER,
        nome TEXT,
        senha TEXT,
        celEmail TEXT,
        dataNascimento TEXT,
        genero TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<Map<String, dynamic>?> doesUsuExist(String email, String senha) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      // Tenta acessar a coleção e buscar documentos que correspondam aos critérios
      QuerySnapshot querySnapshot = await _firestore
          .collection('usuarios')
          .where('celEmail', isEqualTo: email)
          .where('senha', isEqualTo: senha)
          .limit(1)
          .get();

      // Se houver documentos, a avaliação existe
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      }
    } catch (e) {
      // Trate erros, se necessário
      print('Erro ao verificar a existência da avaliação: $e');
      return null;
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
// Sign up
  static Future<void> signUp(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User signed up successfully");
    } catch (e) {
      print("Error during sign up: $e");
    }
  }

// Sign in
  static Future<void> signIn(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User signed in successfully");
    } catch (e) {
      print("Error during sign in: $e");
    }
  }

  static Future<void> sincronizarComFirebase() async {
    // Verificar a conexão antes de sincronizar
    if (await checkInternetConnection()) {
      final db = await SQLUsuarios.db();

      // Obter registros não sincronizados
      final registrosNaoSincronizados =
          await db.query('usuarios', where: "sincronizado = ?", whereArgs: [0]);

      // Enviar registros para o Firebase
      for (var registro in registrosNaoSincronizados) {
        await db.update('usuarios', {'sincronizado': 1},
            where: "id = ?", whereArgs: [registro['id']]);
        await FirebaseFirestore.instance.collection('usuarios').add(registro);

        // Atualizar o campo 'sincronizado' localmente
      }
    }
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

  static Future<int> adicionarUsuario(
      String nome,
      int sincronizado,
      String senha,
      String celEmail,
      String dataNascimento,
      String? genero) async {
    final db = await SQLUsuarios.db();

    final dados = {
      'nome': nome,
      'senha': senha,
      'celEmail': celEmail,
      'dataNascimento': dataNascimento,
      'genero': genero,
      'sincronizado': sincronizado
    };
    final id = await db.insert('usuarios', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> listarUsuarios() async {
    final db = await SQLUsuarios.db();
    return db.query('usuarios', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> validaUsuario(
      String email, String senha) async {
    final db = await SQLUsuarios.db();
    return db.query('usuarios',
        where: "celEmail = ? AND senha = ?",
        whereArgs: [email, senha],
        limit: 1);
  }

  static Future<List<Map<String, dynamic>>> recuperaUsuario(int id) async {
    final db = await SQLUsuarios.db();
    return db.query('usuarios', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> atualizarUsuario(int id, String nome, String senha,
      String celEmail, String dataNascimento, String? genero) async {
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
