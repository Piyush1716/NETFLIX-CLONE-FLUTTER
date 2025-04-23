import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Scaffold(
      body: TabBarView(children: [
        Center(child: Text("H O M E"),),
        Center(child: Text("P R O F I L E"),),
        Center(child: Text("S E T T I N G S"),),
      ]),
      // bottomNavigationBar: TabBar(tabs: [
      //   Tab(icon : Icon(Icons.home)),
      //   Tab(icon : Icon(Icons.person)),
      //   Tab(icon : Icon(Icons.settings)),
      // ]),
    ));
  }
}