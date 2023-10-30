import 'package:flutter/material.dart';
import 'cadastro_screen.dart';
import 'calendario.dart';
import 'profile.dart';
import 'diary_screen.dart';
import 'package:moodmonitor/databases/usuario_db.dart';

class Home extends StatefulWidget{
  int id;

  Home(this.id);

  @override
  _Home createState() => _Home();
}


class _Home extends State<Home> {
  int getId()
  {
    return widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mood Monitor'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Centraliza verticalmente
            children: [
              Text(
                'Olá, como vai seu dia?',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TableScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Cor de fundo do botão
                      onPrimary: Colors.white, // Cor do texto do botão
                      elevation: 3, // Altura da sombra
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Borda arredondada
                      ),
                      textStyle: TextStyle(fontSize: 18), // Estilo do texto
                    ),
                    child: Column(
                      children: [
                        Icon(
                            Icons.calendar_month,
                            size: 100
                        ),
                        Text('Calendário')
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed:(){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage())
                );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Cor de fundo do botão
                      onPrimary: Colors.white, // Cor do texto do botão
                      elevation: 3, // Altura da sombra
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Borda arredondada
                      ),
                      textStyle: TextStyle(fontSize: 18), // Estilo do texto
                    ),
                    child: Column(
                      children: [
                        Icon(
                            Icons.key,
                            size: 100
                        ),
                        Text('Login')
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DiaryScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Cor de fundo do botão
                      onPrimary: Colors.white, // Cor do texto do botão
                      elevation: 3, // Altura da sombra
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Borda arredondada
                      ),
                      textStyle: TextStyle(fontSize: 18), // Estilo do texto
                    ),
                    child: Column(
                      children: [
                        Icon(
                            Icons.add_reaction,
                            size: 100
                        ),
                        Text('Seu dia')
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed:(){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile(widget.id)));

                      //_recuperaUsuario(id);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Cor de fundo do botão
                      onPrimary: Colors.white, // Cor do texto do botão
                      elevation: 3, // Altura da sombra
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Borda arredondada
                      ),
                      textStyle: TextStyle(fontSize: 18), // Estilo do texto
                    ),
                    child: Column(
                      children: [
                        Icon(
                            Icons.face,
                            size: 100
                        ),
                        Text('Perfil')
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*Future _recuperaUsuario(int id) async{
  return await SQLUsuarios.recuperaUsuario(id);
}*/