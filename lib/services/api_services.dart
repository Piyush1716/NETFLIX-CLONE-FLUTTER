import 'dart:convert';
import 'dart:developer';

import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/now_playing_model.dart';
import "package:http/http.dart" as http;
import 'package:netflix/models/serach_movie_model.dart';
import 'package:netflix/models/top_searches_model.dart';
import 'package:netflix/models/tv_series_model.dart';

const baseUrl = "https://api.themoviedb.org/3/";
const api = "?api_key=$apikey";
late String endpoint;

class ApiServices {
  Future<MovieModel> getUpcommingMovies() async{
    endpoint = "movie/upcoming";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));
    
    if(response.statusCode == 200){
      print("Upcomming Success!!");
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    print(response.statusCode);
    throw Exception("Can't load Upcoming Movies!!");

  }
  Future<PopularMoviesModel> getPopularMovies() async{
    endpoint = "movie/popular";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));
    
    if(response.statusCode == 200){
      print("Popular Movies Success!!");
      return PopularMoviesModel.fromJson(jsonDecode(response.body));
    }
    print(response.statusCode);
    throw Exception("Can't load Popular Movies!!");

  }
  
  Future<MovieModel> getNowPlaying() async{
    endpoint = "movie/now_playing";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Now Playing Success!!");
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    print(response.statusCode);
    throw Exception("Can't fetch now playing!!");
  }

  Future<TvSeriesModel> getTopRatedTvSeries() async{
    endpoint = "tv/top_rated";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Top rated Tvs Success!!");
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    print(response.statusCode);
    throw Exception("Can't fetch Top rated tvs!!");
  }

  Future<SerachMovieModel> searchMovie(String movie) async{
    //  url is liek https://api.themoviedb.org/3/search/movie?query=xx&api_key=111
    endpoint = "search/movie?query=$movie";
    final url = "$baseUrl$endpoint&api_key=$apikey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Search Movies Success!!");
      try{return SerachMovieModel.fromJson(jsonDecode(response.body));}
      catch(e){print("json error");}
    }
    print("Error");
    print(response.statusCode);
    throw Exception("Can't Search Movies!!");
  }

}