import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/rec_movie_model.dart';
import 'package:netflix/models/season_Info_model.dart';
import 'package:netflix/services/api_services.dart';

class SeasonEpisods extends StatefulWidget {
  final int id;
  final int seasonNo;
  const SeasonEpisods({super.key, required this.id, required this.seasonNo});

  @override
  State<SeasonEpisods> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<SeasonEpisods> {
  late Future<TvSeasonModel> movieInfo;
  final ApiServices _apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    getSeasonInfo();
  }

  void getSeasonInfo() {
    movieInfo = _apiServices.getSeasonInfo(widget.id, widget.seasonNo);
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
        future: movieInfo,
        builder: (context, snap) {
          if (snap.hasData) {
            var seasons = snap.data;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: ListView.separated(
                itemCount: seasons!.episodes.length,
                itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                        Expanded(child: Text("Episode ${seasons.episodes[index].episodeNumber}",style: TextStyle(fontSize: 18),)),
                        Icon(Icons.star_rounded, color : Colors.amber),
                        Text("${seasons.episodes[index].voteAverage} / 10", style: TextStyle(fontSize: 18),),
                        ],
                      ),
                      Text(seasons.episodes[index].name, maxLines: 2, style: TextStyle(fontSize: 18), overflow: TextOverflow.ellipsis,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: seasons.episodes[index].stillPath!=null ?
                        CachedNetworkImage(
                          imageUrl:
                              "$imgpath${seasons.episodes[index].stillPath}",
                        )
                        : Image.asset("assets/netflix.png")
                      ),
                      SizedBox(height: 8),
                      Text(
                          seasons.episodes[index].overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                    ],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) => Divider(height: 1,color : Colors.white54,),),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
