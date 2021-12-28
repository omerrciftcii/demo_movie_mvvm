import 'package:demo_movie_mvvm/models/movie_model.dart';
import 'package:demo_movie_mvvm/providers/movie_provider.dart';
import 'package:demo_movie_mvvm/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imdbId;
  final String movieName;
  MovieDetailScreen({required this.imdbId, required this.movieName});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    var movieProvider = Provider.of<MoviesProvider>(context, listen: false);
    movieProvider.movieDetailsFuture =
        MovieService.getMovieDetail(imdbId: widget.imdbId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MoviesProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.chevron_left,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Text(
                widget.movieName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: ListView(
                shrinkWrap: true,
                children: [
                  FutureBuilder<MovieModel>(
                    future: movieProvider.movieDetailsFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<MovieModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasError == false) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 37.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image.network(
                                      snapshot.data?.poster ?? '',
                                      width: double.infinity,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              snapshot.data?.title ?? '',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data?.director ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              snapshot.data?.type ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              // height: 500,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.ratings!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(
                                        snapshot.data?.ratings![index].source ??
                                            ''),
                                    subtitle: Text(
                                        snapshot.data?.ratings![index].value ??
                                            ''),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
