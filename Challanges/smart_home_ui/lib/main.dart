import 'package:flutter/material.dart';
import 'package:smart_home_ui/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Home UI Challange",
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: SafeArea(child: HomePage()),
    );
  }
}
