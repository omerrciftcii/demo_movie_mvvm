import 'package:demo_movie_mvvm/failures/failure.dart';
import 'package:demo_movie_mvvm/models/movie_list_item_model.dart';
import 'package:demo_movie_mvvm/models/movie_model.dart';
import 'package:demo_movie_mvvm/screens/favorites_screen.dart';
import 'package:demo_movie_mvvm/services/movie_service.dart';
import 'package:demo_movie_mvvm/widgets/favorites_empty_widget.dart';
import 'package:demo_movie_mvvm/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesProvider extends ChangeNotifier {
  Future<MovieModel>? _movieDetailsFuture;
  Future<MovieModel>? get movieDetailsFuture => _movieDetailsFuture;
  set movieDetailsFuture(value) {
    _movieDetailsFuture = value;
    notifyListeners();
  }

  List<SearchModel>? _movieList;
  List<SearchModel>? get movieList => _movieList;
  set movieList(value) {
    _movieList = value;
    notifyListeners();
  }

  ServerFailure? _failure;
  ServerFailure? get failure => _failure;
  set failure(value) {
    _failure = value;
    notifyListeners();
  }

  List<Widget> screens = [
    SearchWidget(),
    const FavoriteScreen(),
  ];
  int _bottomNavigationBarCurrentIndex = 0;
  int get bottomNavigationBarCurrentIndex => _bottomNavigationBarCurrentIndex;
  set bottomNavigationBarCurrentIndex(value) {
    _bottomNavigationBarCurrentIndex = value;
    notifyListeners();
  }

  Future<void> searchMovies({required String queryString}) async {
    try {
      movieList = <SearchModel>[];
      var response =
          await MovieService.searchMovies(searchParameters: queryString);
      movieList = response.search;
      failure = null;
    } catch (e) {
      failure = ServerFailure(
        errorMessage: e.toString(),
      );
    }
  }

  final List<SearchModel> _favoriteMovies = [];

  List<SearchModel> get favoriteMovies => _favoriteMovies;
  set favoriteMovies(value) {
    notifyListeners();
  }

  final TextEditingController _searchController = TextEditingController(text: '');

  void addMovieToFavorites({required SearchModel movie}) {
    if (favoriteMovies.contains(movie)) {
      favoriteMovies.remove(movie);
    } else {
      favoriteMovies.add(movie);
    }
    notifyListeners();
  }

  TextEditingController get searchController => _searchController;
}
