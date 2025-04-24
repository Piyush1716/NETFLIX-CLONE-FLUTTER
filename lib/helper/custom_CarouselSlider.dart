import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/tv_series_model.dart';

class CustomCarouselslider extends StatelessWidget {
  final TvSeriesModel tvs;
  const CustomCarouselslider({super.key, required this.tvs});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: (size.height * .33 < 300) ? 300 : size.height * .33,
      child: CarouselSlider.builder(
        itemCount: tvs.results.length, 
        itemBuilder: (context, index, realidx){
          var url = tvs.results[index].backdropPath;
            return GestureDetector(child: Column(
              children: [
                Expanded(child: CachedNetworkImage(imageUrl: "$imgpath$url")),
                // SizedBox(height: 5),
                Text(tvs.results[index].name, style: TextStyle(color : Colors.white60,),),
              ],
            ));
          }, 
      options: CarouselOptions(
        height: (size.height * .33 < 300) ? 300 : size.height * .33,
        aspectRatio: 16/9,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        reverse: false,
        enlargeCenterPage: true

      )),
    );
  }
}