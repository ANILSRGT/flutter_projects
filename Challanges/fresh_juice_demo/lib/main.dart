import 'package:flutter/material.dart';
import 'package:fresh_juice_demo/pages/mainpage.dart';

void main() {
  runApp(FreshJuiceDemoApp());
}

class FreshJuiceDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF107A00),
      ),
      title: "Fresh Juice Demo",
      home: MainPage(),
    );
  }
}
