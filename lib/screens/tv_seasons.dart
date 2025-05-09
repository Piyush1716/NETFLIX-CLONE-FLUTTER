import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/tv_info_model.dart';
import 'package:netflix/screens/season_and_episods.dart';

class SeasonsDetail extends StatelessWidget {
  final List<Season> sesons;
  final int id;
  final String title;
  const SeasonsDetail({super.key, required this.sesons, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: sesons.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SeasonEpisods(id: id, seasonNo: sesons[index].seasonNumber)));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: "$imgpath${sesons[index].posterPath}",
                      ),
                    ),
                    SizedBox(width: 25),
                    SizedBox(
                      // width: 260,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${sesons[index].name}",
                            maxLines: 2,
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "${sesons[index].episodeCount} Episods",
                            style: TextStyle(fontSize: 17),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star_rounded, color: Colors.amber),
                              Text(
                                "${sesons[index].voteAverage}",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
