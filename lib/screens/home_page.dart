import 'package:flutter/material.dart';
import 'package:netflix/helper/custom_CarouselSlider.dart';
import 'package:netflix/helper/movie_card.dart';
import 'package:netflix/models/now_playing_model.dart';
import 'package:netflix/models/today_trending_tv_model.dart';
import 'package:netflix/models/tv_series_model.dart';
import 'package:netflix/screens/search_page.dart';
import 'package:netflix/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<MovieModel> upcomings;
  late Future<MovieModel> nowPlaying;
  // late Future<TvSeriesModel> topTvs;
  late Future<TodayTrendingTvModel> topTvs;

  final ApiServices _apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    upcomings = _apiServices.getUpcommingMovies();
    nowPlaying = _apiServices.getNowPlaying();
    topTvs = _apiServices.getTrendinTvToday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/logo.png", height: 50, width: 120),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
          }, icon: Icon(Icons.search, color: Colors.white,)),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 25),
            child: Container(height: 25, width: 25, decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5)),),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(future: topTvs, builder: (context, snap){
              if(snap.connectionState == ConnectionState.waiting){
                return SizedBox(height:300, child: Center(child: CircularProgressIndicator()));
              }
              else if(snap.hasData){
                return CustomCarouselslider(tvs: snap.data!);
              }
              else {return Text("Got Error");}
            }),
            SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: MovieCard(movies: upcomings, heading: "Upcoming Movies"),
            ),
            SizedBox(
              height: 220,
              child: MovieCard(movies: nowPlaying, heading: "Now Playing"),
            ),
          ],
        ),
      ),
    );
  }
}
