import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netflix/helper/comming_soon_card.dart';
import 'package:netflix/helper/top_reated_series_card.dart';
import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/now_playing_model.dart';
import 'package:netflix/models/tv_series_model.dart';
import 'package:netflix/services/api_services.dart';

class NewAndHot extends StatefulWidget {
  const NewAndHot({super.key});

  @override
  State<NewAndHot> createState() => _NewAndHotState();
}

class _NewAndHotState extends State<NewAndHot> {
  late Future<MovieModel> _upComingMovies;
  late Future<TvSeriesModel> _topRatedTvs;

  ApiServices _apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    _upComingMovies = _apiServices.getUpcommingMovies();
    _topRatedTvs = _apiServices.getTopRatedTvSeries();
  }
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
            padding: EdgeInsets.only(bottom: 12),
            labelStyle: TextStyle(fontSize: 15, color : Colors.black, fontWeight: FontWeight.bold),
            indicatorAnimation: TabIndicatorAnimation.linear,
            indicator: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
            unselectedLabelColor: Colors.white,
            dividerColor: Colors.black,
            tabs: [
              Tab(
                child: Text(" 🍿 Comming Soon "),
              ),
              Tab(
                child: Text(" 🔥 Top Series "),
              ),
          ]),
        ),
        body: TabBarView(children: [
          FutureBuilder(
            future: _upComingMovies,
            builder: (context, snap) {
              if(snap.hasData){
                var data = snap.data;
                return ListView.builder(itemCount: data!.results.length, itemBuilder: (context, index){
                  return UpcommingCard(
                          id: data.results[index].id,
                          imgUrl:"$imgpath${data.results[index].posterPath}",
                          overview: data.results[index].overview,
                          posterUrl:"$imgpath${data.results[index].backdropPath}",
                          month: DateFormat('MMM').format(randomDateBetween(data.dates.minimum,data.dates.maximum)),
                          day:  randomDateBetween(data.dates.minimum,data.dates.maximum).day.toString(),
                        );
                },);
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            }
          ),
          FutureBuilder(
            future: _topRatedTvs, 
            builder: (context, snap){
            if(snap.hasData){
              print(snap.data!.totalPages);
              var data = snap.data;
              return ListView.builder(
                itemCount: data!.results.length,
                itemBuilder: (context,index){
                  var tv = data.results[index];
                  return TopRatedCard(id: tv.id, month: "Jun", day: "12", imgUrl: "$imgpath${tv.posterPath}", overview: tv.overview, posterUrl: "$imgpath${tv.backdropPath}");
                });
            } else {
                  return Center(child: CircularProgressIndicator());
                }
          })
        ]),
      ),
    );
  }
}

DateTime randomDateBetween(DateTime start, DateTime end) {
  final rand = Random();
  return start.add(
    Duration(
      milliseconds: rand.nextInt(
        end.millisecondsSinceEpoch - start.millisecondsSinceEpoch,
      ),
    ),
  );
}
