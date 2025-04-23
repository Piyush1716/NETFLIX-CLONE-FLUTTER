import 'dart:convert';
import 'dart:developer';

import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/now_playing_model.dart';
import 'package:netflix/models/upcoming_movie_model.dart';
import "package:http/http.dart" as http;

const baseUrl = "https://api.themoviedb.org/3/";
const api = "?api_key=$apikey";
late String endpoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcommingMovies() async{
    endpoint = "movie/upcoming";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));
    
    if(response.statusCode == 200){
      log("Upcomming Success!!");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Can't load Upcoming Movies!!");

  }
  
  Future<NowPlayingMovieModel> getNowPlaying() async{
    endpoint = "movie/now_playing";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      log("Now Playing Success!!",);
      return NowPlayingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Can't fetch now playing!!");
  }
}