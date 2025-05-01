import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/screens/movie_info.dart';
import 'package:netflix/screens/spalshscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      title: 'Netflix',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 24),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 20),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black).copyWith(surface: Colors.black),
        fontFamily: GoogleFonts.ptSans().fontFamily,
      ),
      // home: Spalshscreen(),
      home: MovieInfo(id: 668489),
    );
  }
}
