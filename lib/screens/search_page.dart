import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/helper/utils.dart';
import 'package:netflix/models/search_tv_model.dart';
import 'package:netflix/models/serach_movie_model.dart';
import 'package:netflix/models/top_searches_model.dart';
import 'package:netflix/screens/movie_info.dart';
import 'package:netflix/services/api_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SerachMovieModel? movies;
  late Future<PopularMoviesModel> popularMovies;
  (SearchTvModel, SerachMovieModel)? tvMovie ;
  TextEditingController _movie = TextEditingController();
  final ApiServices _apiServices = ApiServices();
  void _search(String movie) {
    // print(movie);
    _apiServices.searchMovie(movie).then((data) {
      movies = data;
      setState(() {});
    });
    _apiServices.searchTvMovie(movie).then((data){
      tvMovie = data;
      print(tvMovie!.$1.results.length);
      print(tvMovie!.$2.results.length);
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    popularMovies = _apiServices.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    // horizontal: 12.0,
                    vertical: 25,
                  ),
                  child: CupertinoSearchTextField(
                    padding: EdgeInsets.all(10),
                    controller: _movie,
                    onSubmitted: (value) {
                      if(value!='')
                        _search(_movie.text.toString());
                    },
                    style: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: Icon(Icons.cancel, color: Colors.grey),
                    backgroundColor: Colors.grey[800],
                  ),
                ),
            
                if (_movie.text.isEmpty) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Top Searches",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      FutureBuilder(future: popularMovies, builder: (context, snapshot){
                        if(snapshot.hasData){
                          var popMovie = snapshot.data!.results;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: popMovie.length ,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  height: 150,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo(id: popMovie[index].id)));
                                    },
                                    child: Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: "$imgpath${popMovie[index].posterPath}",
                                        ),
                                        SizedBox(width: 25),
                                        SizedBox(
                                          width: 260,
                                          child: Text("${popMovie[index].title}", maxLines: 2, overflow: TextOverflow.ellipsis,),
                                        ),
                                      ]
                                    ),
                                  ),
                                );
                          });
                        }
                        else{
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                    ],
                  )
                ] else ...[
                  if(tvMovie != null)...[
                    if(tvMovie!.$2.results.isEmpty)...[
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.2 / 2,
                        ),
                        itemCount: tvMovie!.$2.results.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => MovieInfo(
                                        id: movies!.results[index].id,
                                      ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                movies!.results[index].backdropPath != null
                                    ? CachedNetworkImage(
                                      imageUrl:
                                          "$imgpath${movies!.results[index].backdropPath}",
                                      height: 170,
                                    )
                                    : Image.asset(
                                      "assets/netflix.png",
                                      height: 170,
                                    ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    movies!.results[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ]else...[
                      Center(child: Text("No Movie Available!!", style: TextStyle(color : Colors.white,fontSize: 30),))
                    ]
                    
                  ]else...[
                    Center(child: CircularProgressIndicator())
                  ]
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
