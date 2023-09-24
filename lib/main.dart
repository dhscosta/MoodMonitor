import 'package:flutter/material.dart';
import 'screens/diary_screen.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:moodmonitor/calendario.dart';
import 'package:moodmonitor/profile.dart';

void main() {
  runApp(DiaryApp());
}

class DiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DiaryScreen(),
    );
    // This trailing comma makes auto-formatting nicer for build methods.

  }
}
