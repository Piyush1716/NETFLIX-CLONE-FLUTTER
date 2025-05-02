import 'package:flutter/material.dart';

class NewAndHot extends StatelessWidget {
  const NewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hot & New", style: TextStyle(color : Colors.white,),),
          actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.cast, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 25),
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 18, color : Colors.black, fontWeight: FontWeight.bold),
            indicatorAnimation: TabIndicatorAnimation.linear,
            indicator: BoxDecoration(
              color : Colors.white,
              borderRadius: BorderRadius.circular(15)

            ),
            tabs: [
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  10.0),
                  child: Text("🍿 Comming Soon"),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  10.0),
                  child: Text("🔥 Everyone's Watching"),
                ),
              ),
          ]),
        ),
        body: TabBarView(children: [
          Center(child: Text("1"),),
          Center(child: Text("2"),),
        ]),
      ),
    );
  }
}