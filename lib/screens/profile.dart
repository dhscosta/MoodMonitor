import 'package:flutter/material.dart';
import 'package:moodmonitor/databases/usuario_db.dart';
import 'UsuarioAtual.dart';
import 'editprofile.dart';
import 'calendario.dart';
import 'profile.dart';
import 'diary_screen.dart';
import 'Home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:moodmonitor/databases/avaliacoes_db.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  int id;

  Profile(this.id);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    var  name;
    var  email;
    var  dataNascimento;
    double _feliz = 0;
    double _relaxado = 0;
    double _indiferente = 0;
    double _triste = 0;
    double _ansioso = 0;
    double _bravo = 0;
    String avalMedia = "Indiferente";
    IconData icone = FontAwesomeIcons.mehBlank;
    Color cor = Colors.grey;

    Future porcentagem_media() async{
      List<double> retorno = [];
      double total = 0;
      _feliz = 0;
      _relaxado = 0;
      _indiferente = 0;
      _triste = 0;
      _ansioso = 0;
      _bravo = 0;

      List<Map<String, dynamic>> requisicao = await SQLAvaliacoes.recuperarAvaliacoesDoUsuario(widget.id);

      requisicao.forEach((elemento) {
        int aux = (elemento['avaliacaoDia'] != null) ? elemento['avaliacaoDia'] : 0;
        total = total + aux;
        retorno.add(aux.toDouble());
      });

      double media = total / requisicao.length;

      if(media == 0){
        icone = FontAwesomeIcons.mehBlank;
        avalMedia = 'Indiferente';
        cor = Colors.grey;
      }else if(0 < media && media <= 1){
        icone = FontAwesomeIcons.angry;
        avalMedia = 'Bravo';
        cor = Colors.red;
      }else if(1 < media && media <= 2){
        icone = FontAwesomeIcons.tired;
        avalMedia = 'Ansioso';
        cor = Colors.purple;
      }else if(2 < media && media <= 3){
        icone = FontAwesomeIcons.sadTear;
        avalMedia = 'Triste';
        cor = Colors.blue;
      }else if(3 < media && media <= 4){
        icone = FontAwesomeIcons.mehBlank;
        avalMedia = 'Indiferente';
        cor = Colors.grey;
      }else if(4 < media && media <= 5){
        icone = FontAwesomeIcons.smileWink;
        avalMedia = 'Relaxado';
        cor = Colors.green;
      }else if(5 < media){
        icone = FontAwesomeIcons.grinBeam;
        avalMedia = 'Feliz';
        cor = Colors.yellow;
      }

      retorno.forEach((num) {
        switch(num){
          case 1:
            _bravo = _bravo + ((num / total)*100);
          break;
          case 2:
            _ansioso = _ansioso + ((num / total)*100);
          break;
          case 3:
            _triste = _triste + ((num / total)*100);
          break;
          case 4:
            _indiferente = _indiferente + ((num / total)*100);
          break;
          case 5:
            _relaxado = _relaxado + ((num / total)*100);
          break;
          case 6:
            _feliz = _feliz + ((num / total)*100);
          break;
        }
      });

      if(_feliz == 0 && _relaxado == 0 && _indiferente == 0 && _triste == 0 && _ansioso == 0 && _bravo == 0){
        _indiferente = 100;
      }
    }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: Future.wait([
              getName(),
              porcentagem_media(),
            ]),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              else if (snapshot.error != null) {
                return Text('Usuário não logado');
              }
              else {
               // final user =  await SQLUsuarios.recuperaUsuario(widget.id);
               // name=   user[0]['name'];
               // final name = snapshot.data;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      child: FaIcon(FontAwesomeIcons.user, size: 70,),
                      //backgroundImage: AssetImage('assets/user_profile_image.jpg'),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      name ?? "Nome do Usuário",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      email ?? "Email do usuário",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dataNascimento ?? "Data de nascimento do Usuário",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfileEditScreen(widget.id)));
                      },
                      child: Text('Editar Perfil'),
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: <Widget>[
                        Text(
                          "Gráfico de sentimentos",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                            width: 150.0,
                            height: 150.0,
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.yellow,
                                    value: _feliz,
                                    title: "$_feliz%",
                                    radius: 50,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: _relaxado,
                                    title: "$_relaxado%",
                                    radius: 50,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.grey,
                                    value: _indiferente,
                                    title: "$_indiferente%",
                                    radius: 50,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.blue,
                                    value: _triste,
                                    title: "$_triste%",
                                    radius: 50,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.purple,
                                    value: _ansioso,
                                    title: "$_ansioso%",
                                    radius: 50,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.red,
                                    value: _bravo,
                                    title: "$_bravo%",
                                    radius: 50,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LegendBox(color: Colors.yellow, label: 'Feliz'),
                        LegendBox(color: Colors.green, label: 'Relaxado'),
                        LegendBox(color: Colors.grey, label: 'Indiferente'),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LegendBox(color: Colors.blue, label: 'Triste'),
                        LegendBox(color: Colors.purple, label: 'Ansioso'),
                        LegendBox(color: Colors.red, label: 'Bravo'),
                      ],
                    ),
                    SizedBox(height: 40.0),
                    Column(
                      children: <Widget>[
                        Text(
                          "Média de sentimentos",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Text(
                           avalMedia,
                           style: TextStyle(
                             fontSize: 18
                           )
                        ),
                        FaIcon(icone, size: 100, color: cor),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ],
                );
              }
            },
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

  Future getName() async
    {
      final user =  await SQLUsuarios.recuperaUsuario(widget.id);
      name=   user[0]['nome'];
      email = user[0]['celEmail'];
      dataNascimento = user[0]['dataNascimento'];
    }
}

class LegendBox extends StatelessWidget {
  final Color color;
  final String label;

  LegendBox({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
        SizedBox(width: 8),
        Text(label),
        SizedBox(width: 16),
      ],
    );
  }
}
