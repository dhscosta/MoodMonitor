import 'package:flutter/material.dart';
import 'package:moodmonitor/databases/usuario_db.dart';
import 'UsuarioAtual.dart';
import 'editprofile.dart';

class Profile extends StatefulWidget {
  int id;

  Profile(this.id);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
            future: _recuperaUltimoUsuario(),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              else if (snapshot.error != null) {
                return Text('Ocorreu um erro!');
              }
              else {
                final user = snapshot.data;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/user_profile_image.jpg'),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      user?['nome'] ?? "Nome do Usuário",
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
                        Text('Título 1'),
                        Image.asset(
                          'assets/Icon-192.png',
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('Título 2'),
                        Image.asset(
                          'assets/Icon-192.png',
                          width: 100,
                          height: 100,
                        ),
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
    );
  }

  Future _recuperaUltimoUsuario() async {
    final users = await SQLUsuarios.listarUsuarios();
    if (users.isNotEmpty) {
      return users[0];
    }
    return null;
  }
}
