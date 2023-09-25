import 'package:flutter/material.dart';
import 'screens/cadastro_screen.dart';
import 'screens/sobre_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}