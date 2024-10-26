import 'package:flutter/material.dart';
import 'tmdb_service.dart';
import 'movie.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];
  bool _loading = false;

  List<Movie> get movies => _movies;
  bool get loading => _loading;

  final TMDBService _tmdbService = TMDBService();

  Future<void> fetchMovies() async {
    _loading = true;
    notifyListeners();

    _movies = await _tmdbService.fetchPopularMovies()
        .then((data) => data.map((movie) => Movie.fromJson(movie)).toList());

    _loading = false;
    notifyListeners();
  }
}
