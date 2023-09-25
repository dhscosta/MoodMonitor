import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o Aplicativo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Align(
          alignment: Alignment.center,
            child:
              Text(
                'Mood Monitor',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
          ),
          SizedBox(height: 16.0),
          Text(
            'Versão: Beta',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8.0),
          Text(
            'Desenvolvido por: Arthur Patrocínio, Diogo Henrique,'
            'Gabriel Pessotti, Matheus Sinis',
            style: TextStyle(fontSize: 15)
          ),
          SizedBox(height: 16.0),
          Text(
            'Descrição do Aplicativo:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Esse aplicativo foi desenvolvido por 4 estudantes de Ciência da Computação com o objetivo '
              'de incentivar as pessoas a cuidarem mais da própria saúde mental e de tentarem falar'
               'sobre seus problemas. Além disso também criamos com o intuito de que ele possa auxiliar '
                'em processos de tratamento para distúrbios emocionais e mentais. ',
            style: TextStyle(fontSize: 16),
          ),
        ],
        ),
      ),
    );
  }
}