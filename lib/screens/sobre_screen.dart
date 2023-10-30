import 'package:flutter/material.dart';
import 'calendario.dart';
import 'profile.dart';
import 'diary_screen.dart';
import 'Home.dart';



class SobreScreen extends StatelessWidget {
  int id;

  SobreScreen(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o Aplicativo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Align(
          alignment: Alignment.center,
            child:
              Text(
                'Mood Monitor',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
          ),
          SizedBox(height: 16.0),
          Text(
            'Versão: Beta',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8.0),
          Text(
            'Desenvolvido por: Arthur Patrocínio, Diogo Henrique,'
            'Gabriel Pessotti, Matheus Sinis',
            style: TextStyle(fontSize: 15)
          ),
          SizedBox(height: 16.0),
          Text(
            'Descrição do Aplicativo:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Esse aplicativo foi desenvolvido por 4 estudantes de Ciência da Computação com o objetivo '
              'de incentivar as pessoas a cuidarem mais da própria saúde mental e de tentarem falar'
               'sobre seus problemas. Além disso também criamos com o intuito de que ele possa auxiliar '
                'em processos de tratamento para distúrbios emocionais e mentais. ',
            style: TextStyle(fontSize: 16),
          ),
        ],
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
        ],//
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(id)),
              );
              break;
            case 1:
            // teste
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile(id)),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TableScreen(id)),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiaryScreen(id)),
              );
              break;
          }
        },
      ),
    );
  }
}