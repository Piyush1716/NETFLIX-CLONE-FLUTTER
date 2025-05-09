import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netflix/models/tv_info_model.dart';
import 'package:netflix/screens/movie_info.dart';
import 'package:netflix/screens/tv_info.dart';
import 'package:netflix/services/api_services.dart';

class TopRatedCard extends StatefulWidget {
  final int id;
  final String month;
  final String day;
  final String imgUrl;
  final String overview;
  final String posterUrl;

  const TopRatedCard({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.imgUrl,
    required this.overview,
    required this.posterUrl,
  });

  @override
  State<TopRatedCard> createState() => _TopRatedCardState();
}

class _TopRatedCardState extends State<TopRatedCard> {
  late Future<TvInfoModel> tvdetail;
  final ApiServices _apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    get();
  }
  void get(){
    tvdetail = _apiServices.getTvInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: tvdetail,
      builder: (context,snap) {
       if(snap.hasData) {
        var tv = snap.data;
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(height: 20),
                    Text("Seasons", style: TextStyle(color: Colors.white54)),
                    Text(
                      tv!.numberOfSeasons.toString(),
                      style: TextStyle(
                        letterSpacing: 5,
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: widget.imgUrl,
                          width: size.width * 0.75,
                          height: size.height * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: widget.posterUrl,
                              width: 80,
                              height: 60,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                              "EP :  ${tv.numberOfEpisodes}    ",
                              style: TextStyle(fontSize: 18, color: Colors.white54),
                            ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  TvInfo(id: widget.id),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.white54,
                                    ),
                                  ),
                                  Text(
                                    "info",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Last EP : ${DateFormat('yyyy-MM-dd').format(tv.lastAirDate)}",
                              style: TextStyle(fontSize: 18, color: Colors.white54),
                            ),
                          ),
                          Text(
                            "${tv.voteAverage} ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white54,
                            ),
                          ),
                          Icon(Icons.star_rounded,color : Colors.amber,)
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.overview,
                        style: TextStyle(fontSize: 12, color: Colors.white38),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
       }
       else{
        return SizedBox.shrink();
       }
        
      }
    );
  }
}
