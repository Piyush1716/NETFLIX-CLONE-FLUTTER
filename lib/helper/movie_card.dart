import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/now_playing_model.dart';

class MovieCard extends StatelessWidget {
  final Future<MovieModel> movies;
  final String heading;
  const MovieCard({super.key, required this.movies, required this.heading});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: movies, builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        log("waiting");
        return Center(child: CircularProgressIndicator());
      }
      if(snapshot.hasData){
        var d = snapshot.data!;
        var data = d.results;
        log("hava data ");
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.network(
                          "${imgpath}${data[index].posterPath}",
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      return Container();
    });
  }
}
