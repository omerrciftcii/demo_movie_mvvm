import 'dart:convert';

import 'package:demo_movie_mvvm/constants/api_constants.dart';
import 'package:demo_movie_mvvm/models/movie_list_item_model.dart';
import 'package:demo_movie_mvvm/models/movie_model.dart';
import 'package:http/http.dart' as http;
class MovieService {
 static  Future<MovieModel> getMovieDetail({required String imdbId})async{
      final queryParameters = {
      'i': imdbId,
      'apikey': apiKey,
    };
    try {
      final uri = Uri.http(baseUrl, '/', queryParameters);
      final response = await http.get(uri);

      return MovieModel.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      throw Exception(e);
    }
 } 
   static Future<MovieListItemModel> searchMovies({required String searchParameters}) async {
    final queryParameters = {
      's': searchParameters,
      'apikey': apiKey,
    };
    try {
      final uri = Uri.http(baseUrl, '/', queryParameters);
      final response = await http.get(uri);
     
      return MovieListItemModel.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}