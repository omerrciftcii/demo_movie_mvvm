import 'package:demo_movie_mvvm/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MoviesProvider>(
      context,
    );
    return BottomNavigationBar(
        currentIndex: movieProvider.bottomNavigationBarCurrentIndex,
        onTap: (index) {
          movieProvider.bottomNavigationBarCurrentIndex = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            label: 'Favorites',
          ),
        ]);
  }
}
