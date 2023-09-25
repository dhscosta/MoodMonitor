import 'package:flutter/material.dart';


class EditProfileForm extends StatefulWidget {
  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Nome'),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'E-mail'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Salvar as alterações do perfil aqui
            final name = _nameController.text;
            final email = _emailController.text;

            // Exemplo de exibição das informações atualizadas
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Perfil Atualizado'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Nome: $name'),
                      Text('E-mail: $email'),
                    ],
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Fechar'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Salvar Perfil'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}