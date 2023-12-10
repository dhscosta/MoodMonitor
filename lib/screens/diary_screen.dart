import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'calendario.dart';
import 'profile.dart';
import 'Home.dart';
import 'package:moodmonitor/databases/avaliacoes_db.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiaryScreen extends StatefulWidget {
  int id;

  DiaryScreen(this.id, {super.key});
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  int selectedCategory = 0;
  String diaryEntry = "";
  int _indiceAtual = 0;
  TextEditingController _textController = TextEditingController();
  Color corBotao = Colors.white;

  void _setCategory(int valor) {
    setState(() {
      selectedCategory = valor;
    });
  }

  void _saveDiaryEntry() async {
    List<Map<String, dynamic>> resultado = await SQLAvaliacoes.recuperarAvaliacao(widget.id, DateFormat('dd/MM/yyyy').format(DateTime.now()));

    if(resultado.length > 0){
      SQLAvaliacoes.atualizarAvaliacao(resultado[0]['id'], selectedCategory, diaryEntry);
    }else{
      SQLAvaliacoes.adicionarAvaliacao(selectedCategory, diaryEntry, widget.id, DateTime.now());
    }
    await SQLAvaliacoes.sincronizarComFirebase();

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
                buildCategoryButton("Feliz", FaIcon(FontAwesomeIcons.grinBeam, size: 50, color: Colors.yellow), 6),
                buildCategoryButton("Relaxado", FaIcon(FontAwesomeIcons.smileWink, size: 50, color: Colors.green), 5),
                buildCategoryButton("Indiferente", FaIcon(FontAwesomeIcons.mehBlank, size: 50, color: Colors.blueGrey), 4),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCategoryButton("Triste", FaIcon(FontAwesomeIcons.sadTear, size: 50, color: Colors.blue), 3),
                buildCategoryButton("Ansioso", FaIcon(FontAwesomeIcons.tired, size: 50, color: Colors.purple), 2),
                buildCategoryButton("Bravo", FaIcon(FontAwesomeIcons.angry, size: 50, color: Colors.red), 1),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Conte-nos mais sobre o seu dia:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _textController,
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
                onPressed: () {
                  _saveDiaryEntry();
                  _textController.clear();
                  setState(() {
                    corBotao = Colors.white;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Avaliação salva!'),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Ok!'),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.all(16.0),
                      );
                    },
                  );
                },
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

  Widget buildCategoryButton(String category, FaIcon icone, int valor) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: () {
          _setCategory(valor);
          setState(() {
            corBotao = Colors.grey;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: (selectedCategory == valor) ? corBotao : Colors.white,
        ),
        child: Column(
          children: [
            icone,
            SizedBox(height: 5),
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
}