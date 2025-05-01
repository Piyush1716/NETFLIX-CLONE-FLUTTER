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
  void initState() {
    super.initState();
    getMovieInfo();
  }

  void getMovieInfo() async {
    movieInfo = _apiServices.getMovieInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: movieInfo,
        builder: (context, snap) {
          if (snap.hasData) {
            var movie = snap.data;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "$imgpath${movie!.posterPath}",
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      fit: BoxFit.fitWidth,
                    ),
                    Text(movie.originalTitle, style: TextStyle(fontSize: 27),),
                    Row(
                      children: [
                        Text(movie.releaseDate.year.toString(), style: TextStyle(color : Colors.white24, fontSize: 20),),
                        Row(
                          children: movie.genres.map((gener) =>
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(gener.name,style: TextStyle(color : Colors.white24, fontSize: 20),),
                            ),
                          ).toList()
                        )
                    ],),
                    SizedBox(height: 10),
                    Text(movie.overview, style: TextStyle(color: Colors.white60, fontSize: 20),),
                    SizedBox(height: 10),


                    Text("More like this", style: TextStyle(color: Colors.white60, fontSize: 20),),
                    SizedBox(height: 10),

                    
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
