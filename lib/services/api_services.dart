import 'dart:convert';

import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/search_model.dart';
import 'package:netflix/models/search_tv_model.dart';
import 'package:netflix/models/movie_info_model.dart';
import 'package:netflix/models/now_playing_model.dart';
import "package:http/http.dart" as http;
import 'package:netflix/models/rec_movie_model.dart';
import 'package:netflix/models/season_Info_model.dart';
import 'package:netflix/models/serach_movie_model.dart';
import 'package:netflix/models/similar_tv_model.dart';
import 'package:netflix/models/top_searches_model.dart';
import 'package:netflix/models/tv_info_model.dart';
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
      return SerachMovieModel.fromJson(jsonDecode(response.body));
    }
    print("Error");
    print(response.statusCode);
    throw Exception("Can't Search Movies!!");
  }

  // --------- TV Endpoints ------------------
  
   Future<TvSeriesModel> getTopRatedTvSeries() async {
    endpoint = "tv/top_rated";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Top rated Tvs Success!!");
      try{
        var x = TvSeriesModel.fromJson(jsonDecode(response.body));
        return x;
      }
      catch(e){
        print(e);
      }
      print("kjdha");
    }
    print(response.statusCode);
    throw Exception("Can't fetch Top rated tvs!!");
  }
  
  Future<SearchModel> search(String search ,String tv) async{
    endpoint = "search/$search?query=$tv";
    final url = "$baseUrl$endpoint&api_key=$apikey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Search TVs Success!!");
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    print("Error");
    print(response.statusCode);
    throw Exception("Can't Search Tvs!!");
  }
  Future<TvInfoModel> getTvInfo(int id) async {
    endpoint = "tv/${id}";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("TV info Success!!");
      return TvInfoModel.fromJson(jsonDecode(response.body));
    }
    print(response.statusCode);
    throw Exception("Can't fetch TV info!!");
  }
  Future<SimilarTvModel> getSimilarTv(int id) async {
    // https: //api.themoviedb.org/3/tv/1396/similar
    endpoint = "tv/$id/recommendations";
    final url = "$baseUrl$endpoint$api";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Recommended Tv Success!!");
      return SimilarTvModel.fromJson(jsonDecode(response.body));
    }
    print(response.statusCode);
    throw Exception("Can't load Recommendation TV!!");
  }
  Future<TvSeasonModel> getSeasonInfo(int id,int season) async {
    endpoint = "tv/$id/season/$season";
    final url = "$baseUrl$endpoint$api";
    print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Season Info Success!!");
      return TvSeasonModel.fromJson(jsonDecode(response.body));
    }
    print(response.statusCode);
    throw Exception("Can't load Season info!!");
  }
}