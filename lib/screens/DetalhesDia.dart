import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodmonitor/databases/avaliacoes_db.dart';
import 'calendario.dart';
import 'profile.dart';
import 'diary_screen.dart';
import 'Home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetalhesDia extends StatefulWidget {
  int id;
  String dia;

  DetalhesDia(this.id, this.dia);
  @override
  _DetalhesDia createState() => _DetalhesDia(dia);
}

class _DetalhesDia extends State<DetalhesDia>{
  String dia;
  Map<String, dynamic> avaliacao = Map();
  _DetalhesDia(this.dia);

  Future<Map<String, dynamic>> consultaAvaliacao()async{
    List<Map<String, dynamic>> resultado = await SQLAvaliacoes.recuperarAvaliacao(widget.id, dia);
    if(resultado.length > 0){
      return Map<String, dynamic>.from(resultado[0]);
    }else{
      return Map();
    }
  }

  IconData recuperaIcone(int valor){
    IconData icone = FontAwesomeIcons.mehBlank;
    switch(valor){
      case 1:
        icone = FontAwesomeIcons.angry;
      break;
      case 2:
        icone = FontAwesomeIcons.tired;
      break;
      case 3:
        icone = FontAwesomeIcons.sadTear;
      break;
      case 4:
        icone = FontAwesomeIcons.mehBlank;
      break;
      case 5:
        icone = FontAwesomeIcons.smileWink;
      break;
      case 6:
        icone = FontAwesomeIcons.grinBeam;
      break;
    }
    return icone;
  }

  Color recuperaCor(int valor){
    Color color = Colors.grey;
    switch(valor){
      case 1:
        color = Colors.red;
        break;
      case 2:
        color = Colors.purple;
        break;
      case 3:
        color = Colors.blue;
        break;
      case 4:
        color = Colors.grey;
        break;
      case 5:
        color = Colors.green;
        break;
      case 6:
        color = Colors.yellow;
        break;
    }
    return color;
  }

  Future<Widget> tela() async{
    await SQLAvaliacoes.sincronizarAvaliacoesPorUsuario(widget.id);
    avaliacao = await consultaAvaliacao();
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text(
                dia,
                style: TextStyle(
                    fontSize: 50
                ),
              )],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FaIcon(
                    recuperaIcone(avaliacao['avaliacaoDia'] != null ? avaliacao['avaliacaoDia'] : 0),
                    size: 100,
                    color: recuperaCor(avaliacao['avaliacaoDia'] != null ? avaliacao['avaliacaoDia'] : 0),
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
                        (avaliacao['poucoDoDia'] != null) ? avaliacao['poucoDoDia'] : "Sem registros na data selecionada",
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
    );
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do Dia'),
          centerTitle: true,
        ),
        body: FutureBuilder<Widget>(
          future: tela(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Text('Erro: ${snapshot.error}');
            }else{
              return snapshot.data ?? Container();
            }
          },
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
    //);
  }
}