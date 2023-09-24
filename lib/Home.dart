import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){

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