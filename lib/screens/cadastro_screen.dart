import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'Home.dart';
import 'sobre_screen.dart';
import 'package:moodmonitor/databases/usuario_db.dart';
import 'calendario.dart';
import 'profile.dart';
import 'diary_screen.dart';

/*class _LoginPageState extends StatefulWidget {
  @override
  LoginPage createState() => LoginPage();
}*/

class LoginPage extends StatelessWidget {
  String senha = "";
  String email = "";
  int id;

  LoginPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //email
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(height: 16.0),
              //senha
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  senha = value;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  //_validarUsuario(email, senha);
                  final usuarios =
                      await SQLUsuarios.validaUsuario(email, senha);
                  if (usuarios.isEmpty) {
                    final usu = await SQLUsuarios.doesUsuExist(email, senha);
                    if (usu != null) {
                      //criar no db local
                      await SQLUsuarios.adicionarUsuario(
                          usu['nome'],
                          usu['sincronizado'],
                          usu['senha'],
                          usu['celEmail'],
                          usu['dataNascimento'],
                          usu['genero']);
                      // valida ?
                      await SQLUsuarios.validaUsuario(
                          usu['celEmail'], usu['senha']);
                      var id = usu['id'];
                      print("QUE SACO" + id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home(id)),
                      );
                    } else {
                      _erroLogin(context,
                          "Erro ao fazer login. Verifique suas credenciais.");
                    }
                  } else {
                    final idDoUsuario = usuarios.first['id'];
                    var id = idDoUsuario;
                    print('teste2');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home(id)),
                    );
                  }
                },
                child: const Text('Entrar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroScreen(id)),
                  );
                },
                child: const Text('Cadastre-se'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SobreScreen(id)),
                  );
                },
                child: const Text('Sobre'),
              ),
            ],
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
        ], //
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(id)),
              );
              break;
            case 1:
              // teste
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile(id)),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TableScreen(id)),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiaryScreen(id)),
              );
              break;
          }
        },
      ),
    );
  }

  void _erroLogin(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class CadastroScreen extends StatelessWidget {
  String nome = "";
  String email = "";
  String senha = "";
  String dataNascimento = "";
  String? genero = "Indefinido";

  int id;

  List<String> generos = ['Masculino', 'Feminino', 'Outro', 'Indefinido'];

  TextEditingController _controller = TextEditingController();
  final MaskTextInputFormatter _maskFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  CadastroScreen(this.id, {super.key});

  @override
  StatefulWidget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //nome
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  nome = value;
                },
              ),

              const SizedBox(height: 16.0),
              //email
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              
              const SizedBox(height: 16.0),
              //Senha
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  senha = value;
                },
              ),

              const SizedBox(height: 16.0),
              //data de nascimento
              TextFormField(
                controller: _controller,
                keyboardType: TextInputType.datetime,
                inputFormatters: [_maskFormatter],
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                  hintText: 'DD/MM/YYYY',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  dataNascimento = value;
                },
              ),

              const SizedBox(height: 16.0),
              //escolha de genero
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gênero'),
                value: genero,
                onChanged: (novoGenero) {
                  genero = novoGenero;
                },
                items: generos.map((genero) {
                  return DropdownMenuItem<String>(
                    value: genero,
                    child: Text(genero),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _adicionarUsuario(nome, senha, email, dataNascimento, genero);

                  print("$nome $senha $email $dataNascimento $genero");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage(id)));
                },
                child: const Text('Cadastrar'),
              ),
            ],
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
        ], //
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(id)),
              );
              break;
            case 1:
              // teste
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile(id)),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TableScreen(id)),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiaryScreen(id)),
              );
              break;
          }
        },
      ),
    );
  }
}

Future _adicionarUsuario(String nome, String senha, String celEmail,
    String dataNascimento, String? genero) async {
  await SQLUsuarios.adicionarUsuario(
      nome, 0, senha, celEmail, dataNascimento, genero);
  await SQLUsuarios.signUp(celEmail, senha);
  await SQLUsuarios.signIn(celEmail, senha);
  await SQLUsuarios.sincronizarComFirebase();
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
