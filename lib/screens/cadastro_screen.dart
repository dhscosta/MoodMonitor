import 'package:flutter/material.dart';
import 'Home.dart';
import 'sobre_screen.dart';
import 'package:moodmonitor/databases/usuario_db.dart';

/*class _LoginPageState extends StatefulWidget {
  @override
  LoginPage createState() => LoginPage();
}*/

class LoginPage extends StatelessWidget {
  String senha = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //email
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                email = value;
              },
            ),
            SizedBox(height: 16.0),
            //senha
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                senha = value;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                //_validarUsuario(email, senha);
                final usuarios = await SQLUsuarios.validaUsuario(email, senha);

                if(usuarios.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('ERRO!'),
                        content: Text('Nao foi possivel fazer o login.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );

              },
              child: Text('Entrar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroScreen()),
                );
              },
              child: Text('Cadastre-se'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SobreScreen()),
                );
              },
              child: Text('Sobre'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class CadastroScreen extends StatelessWidget {
  String nome = "";
  String email = "";
  String senha = "";
  String dataNascimento = "";
  String? genero = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //nome
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                nome = value;
              },
            ),
            SizedBox(height: 16.0),
            //email
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                email = value;
              },
            ),
            SizedBox(height: 16.0),
            //email
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                senha = value;
              },
            ),
            SizedBox(height: 16.0),
            //data de nascimento
            Text(
              'Data de Nascimento',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                dataNascimento = value;
              },
            ),
            SizedBox(height: 16.0),
            //escolha de genero
            Text(
              'Gênero',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              value: null, // Valor inicial (implementar depois)
              onChanged: (value) {
                genero = value;// Funcionalidade para quando selecionar (implementar depois)
              },
              items: <String>[
                'Masculino',
                'Feminino',
                'Outro',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _adicionarUsuario(nome, senha, email, dataNascimento, genero);
                print(nome + " " + senha);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage())
                );
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

Future _adicionarUsuario(String nome, String senha, String celEmail, String dataNascimento, String? genero) async{
  await SQLUsuarios.adicionarUsuario(nome, senha, celEmail, dataNascimento, genero);
}

//Future _validarUsuario(String email, String senha) async {
  //final usuarios = await SQLUsuarios.validaUsuario(email, senha);
  //await SQLUsuarios.validaUsuario(email, senha);

  /*if(usuarios.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('ERRO!'),
          content: Text('Nao foi possivel fazer o login.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    //print('Erro ao fazer o login!');
  }*/
  /*else {
    print('DEU CERTO');
  }*/
//}

Future _validarUsuario(String email, String senha) async {
  await SQLUsuarios.validaUsuario(email, senha);
}

/*Future _validarUsuario(String email, String senha) async {
  //String? _errorMessage;
  //bool teste = false;
  List dados = await SQLUsuarios.validaUsuario(email, senha);
  //await SQLUsuarios.validaUsuario(email, senha);
  if(dados[0] != null && dados[1] != null) {
    //teste = true;
    print("Login bem sucedido!");
  }
  else if(dados[0] == null && dados[1] == null) {
    print("Erro ao fazer o login!");
  }

  //return teste;
}*/

/*Future _recuperaUsuario(int id) async{
  return await SQLUsuarios.recuperaUsuario(id);
}*/