import 'package:flutter/material.dart';
import 'Home.dart';
import 'diary_screen.dart';
import 'calendario.dart';
import 'profile.dart';

class DetalhesDia extends StatefulWidget {
  @override
  _DetalhesDia createState() => _DetalhesDia();
}

class _DetalhesDia extends State<DetalhesDia>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Dia'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Ícone de seta para voltar
            onPressed: () {
              Navigator.pop(context); // Função para voltar à tela anterior
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text(
                    '25/09/2023',
                    style: TextStyle(
                      fontSize: 50
                    ),
                )],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '😊',
                    style: TextStyle(
                      fontSize: 100
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 250,
                        height: 500,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et tincidunt magna. Ut euismod urna elit, sed condimentum orci vestibulum quis. Aliquam ut viverra ipsum, ut pretium dui. Curabitur eu hendrerit tortor. Curabitur facilisis metus felis. Phasellus at gravida risus. Pellentesque sit amet purus sit amet enim fringilla vestibulum. Proin a ligula nec massa hendrerit auctor quis id justo. Donec dapibus nec lacus non faucibus. Mauris rutrum metus risus, sed rutrum tellus molestie ut.\nMauris sagittis velit purus, in ullamcorper ipsum accumsan ut. Cras quis quam in nibh fringilla eleifend. Proin nec lectus eget mauris vestibulum condimentum in sed lacus.',
                          softWrap: true,
                        ),
                      )
                    ],
                  )
                ],
              )
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
      ),
    );
  }
}