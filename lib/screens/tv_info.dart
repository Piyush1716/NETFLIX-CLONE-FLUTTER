import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/similar_tv_model.dart';
import 'package:netflix/models/tv_info_model.dart';
import 'package:netflix/screens/tv_seasons.dart';
import 'package:netflix/services/api_services.dart';

class TvInfo extends StatefulWidget {
  final int id;
  const TvInfo({super.key, required this.id});

  @override
  State<TvInfo> createState() => _TvInfoState();
}

class _TvInfoState extends State<TvInfo> {
  late Future<TvInfoModel> tvInfo;
  late Future<SimilarTvModel> recommendations;
  final ApiServices _apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    getTvInfo();
  }

  void getTvInfo() {
    tvInfo = _apiServices.getTvInfo(widget.id);
    recommendations = _apiServices.getSimilarTv(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: tvInfo,
        builder: (context, snap) {
          if (snap.hasData) {
            var movie = snap.data;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: "$imgpath${movie!.backdropPath}",
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                movie!.name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(Icons.star_rounded, color: Colors.amber,),
                            Text(
                              "${movie!.voteAverage.toString()}/10",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                movie.firstAirDate.year.toString(),
                                style: TextStyle(
                                  color: Colors.white54,
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
                                                color: Colors.white54,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonsDetail( sesons: movie.seasons, id: movie.id, title: movie.name,)));
                              },
                              child: Text(
                                "Episods/Sesons : ${movie.numberOfEpisodes}/${movie.numberOfSeasons}",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white70,
                                  fontSize: 15,
                                  color : Colors.white54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Status : ${movie.status}",
                              style: TextStyle(
                                fontSize: 15,
                                color : Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          movie.overview,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white70, fontSize: 17,),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                    FutureBuilder(
                      future: recommendations,
                      builder: (context, snap) {
                        if (snap.hasData) {
                          var movies = snap.data;
                          if (movies!.results.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "More like this",
                                  style: TextStyle(
                                    color: Colors.white24,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 10),
                                GridView.builder(
                                  itemCount: movies.results.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                      ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => TvInfo(id: movies.results[index].id,)));
                                        }
                                        ,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$imgpath${movies.results[index].posterPath}",
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.4,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else {
                            return Text(
                              "No Movies to Recommend.",
                              style: TextStyle(
                                color: Colors.white30,
                                fontSize: 15,
                              ),
                            );
                          }
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
