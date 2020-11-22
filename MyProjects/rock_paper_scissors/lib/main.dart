import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/screens/gamescreen.dart';
import 'package:rock_paper_scissors/screens/mainscreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/game': (context) => GameScreen(),
      },
    ),
  );
}
