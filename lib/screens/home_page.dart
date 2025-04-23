import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logo.png", height: 50, width: 120),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, color: Colors.white,)),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 25),
            child: Container(height: 25, width: 25, decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5)),),
          ),
        ],
      ),
    );
  }
}
