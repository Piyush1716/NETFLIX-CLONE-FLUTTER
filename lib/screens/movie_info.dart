import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/movie_info_model.dart';
import 'package:netflix/models/rec_movie_model.dart';
import 'package:netflix/services/api_services.dart';

class MovieInfo extends StatefulWidget {
  final int id;
  const MovieInfo({super.key, required this.id});

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  late Future<MovieInfoModel> movieInfo;
  late Future<RecMovieModel> recommendations;
  final ApiServices _apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    getMovieInfo();
  }

  void getMovieInfo() {
    movieInfo = _apiServices.getMovieInfo(widget.id);
    recommendations = _apiServices.getRecommendations(widget.id);
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
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: "$imgpath${movie!.posterPath}",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),

                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style: TextStyle(
                                color: Colors.white24,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children:
                                  movie.genres
                                      .map(
                                        (gener) => Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                          ),
                                          child: Text(
                                            gener.name,
                                            style: TextStyle(
                                              color: Colors.white24,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          movie.overview,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white60, fontSize: 20),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    Text(
                      "More like this",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 10),

                    FutureBuilder(
                      future: recommendations,
                      builder: (context, snap) {
                        if (snap.hasData) {
                          var movies = snap.data;
                          return GridView.builder(
                            itemCount: movies!.results.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder:(context) =>MovieInfo(id: movies.results[index].id),),);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "$imgpath${movies.results[index].posterPath}",
                                    height:
                                        MediaQuery.of(context).size.height * 0.4,
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Text("Error occured while loading!!");
                        }
                      },
                    ),
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
