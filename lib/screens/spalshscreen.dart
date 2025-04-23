import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix/common/bottom_navbar.dart';
import 'package:netflix/screens/home_page.dart';

class Spalshscreen extends StatefulWidget {
  const Spalshscreen({super.key});

  @override
  State<Spalshscreen> createState() => _SpalshscreenState();
}

class _SpalshscreenState extends State<Spalshscreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 0), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (conext) => BottomNavbar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
      child: Lottie.asset("assets/netflix.json"),
    )
    );
  }
}