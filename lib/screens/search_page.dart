import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/serach_movie_model.dart';
import 'package:netflix/services/api_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SerachMovieModel? movies;
  TextEditingController _movie = TextEditingController();
  final ApiServices _apiServices = ApiServices();
  void _search(String movie) {
    // print(movie);
    _apiServices.searchMovie(movie).then((data) {
      print("dajdk");
      movies = data;
      print(data.totalPages);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 25,
                ),
                child: CupertinoSearchTextField(
                  padding: EdgeInsets.all(10),
                  controller: _movie,
                  onSubmitted: (value) {
                    _search(_movie.text.toString());
                  },
                  style: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: Icon(Icons.cancel, color: Colors.grey),
                  backgroundColor: Colors.grey[800],
                ),
              ),

              if (movies == null) ...[
                SizedBox.shrink(),
              ] else ...[
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.2 / 2,
                  ),
                  itemCount: movies!.results.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        movies!.results[index].backdropPath != null
                            ? CachedNetworkImage(
                              imageUrl:
                                  "$imgpath${movies!.results[index].backdropPath}",
                              height: 200,
                            )
                            : SizedBox(height: 200,),
                        Text(
                          movies!.results[index].title,
                          style: TextStyle(color: Colors.white70, fontSize: 8),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
