import 'package:flutter/material.dart';
import 'package:moodmonitor/databases/usuario_db.dart';
import 'editprofile.dart';
import 'calendario.dart';
import 'diary_screen.dart';
import 'Home.dart';

class Profile extends StatefulWidget {
  int id;

  Profile(this.id, {super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    var  name ;
    var  email;
    var  dataNascimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future:  getName(),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              else if (snapshot.error != null) {
                return const Text('Usuário não logado');
              }
              else {
               // final user =  await SQLUsuarios.recuperaUsuario(widget.id);
               // name=   user[0]['name'];
               // final name = snapshot.data;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/user_profile_image.jpg'),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      name ?? "Nome do Usuário",
                      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      email ?? "Email do usuário",
                      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dataNascimento ?? "Data de nascimento do Usuário",
                      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfileEditScreen(widget.id)));
                      },
                      child: const Text('Editar Perfil'),
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      children: <Widget>[
                        const Text('Título 1'),
                        Image.asset(
                          'assets/Icon-192.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Text('Título 2'),
                        Image.asset(
                          'assets/Icon-192.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 8.0),
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

  Future getName() async
    {
      final user =  await SQLUsuarios.recuperaUsuario(widget.id);
      name=   user[0]['nome'];
      email = user[0]['celEmail'];
      dataNascimento = user[0]['dataNascimento'];
    }




}
