import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Perfil de Usuário'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centralize verticalmente
            crossAxisAlignment: CrossAxisAlignment.center, // Centralize horizontalmente
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/user_profile_image.jpg'), // Substitua pelo caminho da imagem do usuário
              ),
              SizedBox(height: 10.0),
              Text(
                'Nome do Usuário',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Função a ser executada ao pressionar o botão
                },
                child: Text('Editar Perfil'),
              ),
              SizedBox(height: 20.0),
              IconButton(
                icon: Icon(
                  Icons.calendar_month, // Ícone a ser exibido
                  size: 100.0, // Defina o tamanho do ícone
                ),
                onPressed: () {
                  // Função a ser executada quando o botão é pressionado
                  print('Bigger IconButton pressed');
                },
              ),
              SizedBox(height: 20.0),
              Column(
                children: <Widget>[
                  Text('Título 1'),
                  Image.asset(
                    'web/icons/Icon-192.png', // Substitua pelo caminho da primeira imagem
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
                    'web/icons/Icon-192.png', // Substitua pelo caminho da segunda imagem
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
