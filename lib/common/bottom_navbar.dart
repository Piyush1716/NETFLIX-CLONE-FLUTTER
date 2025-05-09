import 'package:flutter/material.dart';
import 'package:netflix/screens/home_page.dart';
import 'package:netflix/screens/new_and_hot.dart';
import 'package:netflix/screens/search_page.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        body: TabBarView(children: [
          HomePage(),
          SearchPage(),
          NewAndHot()
        ]),
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(text: "Home", icon: Icon(Icons.home)),
              Tab(text: "Search", icon: Icon(Icons.search)),
              Tab(text: "New & Hot", icon: Icon(Icons.photo_library_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
