import 'package:flutter/material.dart';
import 'package:moodmonitor/databases/usuario_db.dart';
import 'Home.dart';

class UserProfileEditScreen extends StatefulWidget {
   int id;

  UserProfileEditScreen(this.id);

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

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(widget.id)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            TextField(
              controller: _birthController,
              decoration: InputDecoration(labelText: 'Data de Nascimento'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateUserProfile,
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}