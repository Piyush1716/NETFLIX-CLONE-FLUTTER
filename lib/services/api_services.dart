import 'dart:convert';

import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/search_tv_model.dart';
import 'package:netflix/models/movie_info_model.dart';
import 'package:netflix/models/now_playing_model.dart';
import "package:http/http.dart" as http;
import 'package:netflix/models/rec_movie_model.dart';
import 'package:netflix/models/serach_movie_model.dart';
import 'package:netflix/models/top_searches_model.dart';
import 'package:netflix/models/tv_series_model.dart';

const baseUrl = "https://api.themoviedb.org/3/";
const api = "?api_key=$apikey";
late String endpoint;

class ApiServices {

  // --------- Movie Endpoints ------------------

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
  Future<RecMovieModel> getRecommendations(int id) async{
    // https: //api.themoviedb.org/3/movie/668489/recommendations
    endpoint = "movie/$id/recommendations";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));
    
    if(response.statusCode == 200){
      print("Recommended Movies Success!!");
      return RecMovieModel.fromJson(jsonDecode(response.body));
    }
    print(response.statusCode);
    throw Exception("Can't load Recommendation Movies!!");
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
  Future<MovieInfoModel> getMovieInfo(int id) async{
    endpoint = "movie/${id}";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Movie info Success!!");
      return MovieInfoModel.fromJson(jsonDecode(response.body));
    }
    print(response.statusCode);
    throw Exception("Can't fetch Movie info!!");
  }

  Future<SerachMovieModel> searchMovie(String movie) async{
    //  url is like https://api.themoviedb.org/3/search/movie?query=xx&api_key=111
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
  Future<(SearchTvModel, SerachMovieModel)> searchTvMovie(String movie) async{
    String movieApi = "search/movie?query=$movie";
    String tvApi = "search/tv?query=$movie";
    final urlMovie = "$baseUrl$movieApi&api_key=$apikey";
    final urlTv = "$baseUrl$tvApi&api_key=$apikey";
    final responseMovie = await http.get(Uri.parse(urlMovie));
    final responseTv = await http.get(Uri.parse(urlTv));

    if(responseTv.statusCode == 200 && responseMovie.statusCode == 200){
      SerachMovieModel movies = SerachMovieModel.fromJson(jsonDecode(responseMovie.body));
      SearchTvModel tvs = SearchTvModel.fromJson(jsonDecode(responseTv.body));

      return (tvs, movies);
    }
    print("Error");
    throw Exception("Can't Search Movies!!");
  }

  // --------- TV Endpoints ------------------
  
   Future<TvSeriesModel> getTopRatedTvSeries() async {
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
}