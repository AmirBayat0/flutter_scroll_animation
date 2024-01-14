import 'package:flutter/material.dart';
import 'package:flutter_scroll_animation/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.titilliumWebTextTheme(),
      ),
      home: const FinalView(),
    );
  }
}
