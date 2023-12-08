import 'package:flutter/material.dart';
import 'package:moodmonitor/databases/usuario_db.dart';
import 'calendario.dart';
import 'profile.dart';
import 'diary_screen.dart';
import 'Home.dart';

class UserProfileEditScreen extends StatefulWidget {
   int id;

  UserProfileEditScreen(this.id, {super.key});

  @override
  _UserProfileEditScreenState createState() => _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends State<UserProfileEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();


  @override
  void initState() {
    super.initState();
    SQLUsuarios.recuperaUsuario(widget.id);
  }

  Future<void> updateUserProfile() async {
    final nome = _nameController.text;
    final celEmail = _emailController.text;
    final senha = _passwordController.text;
    final dataNascimento = _birthController.text;


    await SQLUsuarios.atualizarUsuario(widget.id, nome, senha, celEmail, dataNascimento, null);

    Map<String, dynamic> novosAtributos = {
      'nome': nome,
      'senha': senha,
      'celEmail': celEmail,
      'dataNascimento': dataNascimento,

    };

    await SQLUsuarios.atualizarFirebase(widget.id,novosAtributos );
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(widget.id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            TextField(
              controller: _birthController,
              decoration: const InputDecoration(labelText: 'Data de Nascimento'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateUserProfile,
              child: const Text('Salvar Alterações'),
            ),
          ],
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
}