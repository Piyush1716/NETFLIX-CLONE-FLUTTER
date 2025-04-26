import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/movie_info_model.dart';
import 'package:netflix/services/api_services.dart';

class MovieInfo extends StatefulWidget {
  final int id;
  const MovieInfo({super.key, required this.id});

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  late Future<MovieInfoModel> movieInfo;
  final ApiServices _apiServices = ApiServices();
  @override
  void initState(){
    super.initState();
    getMovieInfo();
  }

  void getMovieInfo()async{
    movieInfo =  _apiServices.getMovieInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: movieInfo, builder: (context, snap){
        if(snap.hasData){
          var movie = snap.data;
          return Column(
            children: [
              CachedNetworkImage(imageUrl: "$imgpath${movie!.posterPath}", height: 200,),
              Text(movie.originalTitle),
            ],
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}