import 'package:flutter/material.dart';
import 'calendario.dart';
import 'profile.dart';
import 'Home.dart';
import 'package:moodmonitor/databases/avaliacoes_db.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DiaryScreen extends StatefulWidget {
  int id;

  DiaryScreen(this.id, {super.key});
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  String selectedCategory = "Muito Feliz";
  String diaryEntry = "";
  final int _indiceAtual = 0;

  void _setCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _saveDiaryEntry() {
    print("Categoria: $selectedCategory");
    print("Diário: $diaryEntry");
    adicionarAvaliacao(selectedCategory,diaryEntry, widget.id);
    SQLAvaliacoes.sincronizarComFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Diário'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Como foi o seu dia?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCategoryButton("Feliz", "😊"),
                buildCategoryButton("Relaxado", "😌"),
                buildCategoryButton("Indiferente", "😐"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCategoryButton("Triste", "😢"),
                buildCategoryButton("Ansioso", "😰"),
                buildCategoryButton("Bravo", "😡"),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Conte-nos mais sobre o seu dia:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 5,
              onChanged: (text) {
                diaryEntry = text;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Descreva seu dia aqui...',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveDiaryEntry,
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Início",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Perfil",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Saldo",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions),
              label: "Mapa",
              backgroundColor: Colors.blue),
        ],//
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(widget.id)),
              );
              break;
            case 1:
            // teste
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile(widget.id)),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TableScreen(widget.id)),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiaryScreen(widget.id)),
              );
              break;
          }
        },
      ),
    );
  }

  Widget buildCategoryButton(String category, String emoji) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: () {
          _setCategory(category);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedCategory == category ? Colors.blue : Colors.white,
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 10),
            Text(
                category,
                style: const TextStyle(
                  color: Colors.black,
                )
            ),
          ],
        ),
      ),
    );


  }
  static Future<int> adicionarAvaliacao(String avaliacaoDia, String poucoDoDia, int idUsuario) async {
    final db = await SQLAvaliacoes.db();

    final dados = {'avaliacaoDia': avaliacaoDia, 'poucoDoDia': poucoDoDia, 'idUsuario': idUsuario};
    final id = await db.insert('avaliacoes', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }
}