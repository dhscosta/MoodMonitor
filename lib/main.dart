import 'package:flutter/material.dart';
import 'screens/diary_screen.dart';

void main() {
  runApp(DiaryApp());
}

class DiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DiaryScreen(),
    );
  }
}
