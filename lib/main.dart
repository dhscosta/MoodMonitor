import 'package:flutter/material.dart';
import 'screens/Home.dart';

void main() {
  runApp(DiaryApp());
}

class DiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    );
    // This trailing comma makes auto-formatting nicer for build methods.

  }
}
