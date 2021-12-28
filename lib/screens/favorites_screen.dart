import 'package:demo_movie_mvvm/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MoviesProvider>(
      context,
    );
    return movieProvider.favoriteMovies.isEmpty
        ? const Center(
            child: Text('Your favorite list is empty'),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: movieProvider.favoriteMovies.length,
            itemBuilder: (context, int index) {
              return ListTile(
                leading: Image.network(
                    movieProvider.favoriteMovies[index].poster ?? ''),
                title: Text(movieProvider.favoriteMovies[index].title ?? ''),
                subtitle: Text(movieProvider.favoriteMovies[index].year ?? ''),
                trailing: const Icon(Icons.favorite),
              );
            },
          );
  }
}
