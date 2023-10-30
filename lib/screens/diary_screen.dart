import 'package:flutter/material.dart';
import 'package:moodmonitor/databases/avaliacoes_db.dart';
import 'Home.dart';
import 'diary_screen.dart';
import 'calendario.dart';
import 'profile.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  String selectedCategory = "Muito Feliz";
  String diaryEntry = "";
  int _indiceAtual = 0;

  void _setCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _saveDiaryEntry() {
    print("Categoria: $selectedCategory");
    print("Diário: $diaryEntry");
   // adicionarAvaliacao(selectedCategory,diaryEntry,  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Diário'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Como foi o seu dia?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCategoryButton("Feliz", "😊"),

                buildCategoryButton("Relaxado", "😌"),
                buildCategoryButton("Indiferente", "😐"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCategoryButton("Triste", "😢"),
                buildCategoryButton("Ansioso", "😰"),
                buildCategoryButton("Bravo", "😡"),
              ],
            ),
            SizedBox(height: 15),
            Text(
              'Conte-nos mais sobre o seu dia:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 5,
              onChanged: (text) {
                diaryEntry = text;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Descreva seu dia aqui...',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveDiaryEntry,
                child: Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        items: [
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
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
              break;
            case 1:
            // teste
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TableScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiaryScreen()),
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
          primary: selectedCategory == category ? Colors.blue : Colors.white,
        ),
        child: Column(
          children: [
            Text(emoji, style: TextStyle(fontSize: 30)),
            SizedBox(height: 10),
            Text(
                category,
                style: TextStyle(
                  color: Colors.black,
                )
            ),
          ],
        ),
      ),
    );
  }
}