import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/screens/movie_info.dart';

class UpcommingCard extends StatelessWidget {
  final int id;
  final String month;
  final String day;
  final String imgUrl;
  final String overview;
  final String posterUrl;

  const UpcommingCard({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.imgUrl,
    required this.overview,
    required this.posterUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              Text(month, style: TextStyle(color: Colors.white54)),
              Text(
                day,
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
                    imageUrl: imgUrl,
                    width: size.width * 0.75,
                    height: size.height * 0.6,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: posterUrl,
                        width: 80,
                        height: 60,
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.notifications_none, color: Colors.white),
                            Text("Notify Me", style: TextStyle(color : Colors.white,fontSize: 10),)
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo(id: id)));
                              },
                              child: Icon(Icons.info_outline, color: Colors.white,)
                              ),
                            Text("info", style: TextStyle(color : Colors.white,fontSize: 10),)
                          ],
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Comming on $month $day",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  overview,
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
}
