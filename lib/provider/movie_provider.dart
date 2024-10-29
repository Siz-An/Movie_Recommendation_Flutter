import 'package:flutter/material.dart'; // Adjust according to your movie model
import 'package:http/http.dart' as http;

import '../Screen/movie.dart'; // Make sure to import necessary packages

class MovieProvider with ChangeNotifier {
  List<Movie> _popularMovies = [];
  List<Movie> _recentlyAddedMovies = [];
  bool _loading = false;

  // Getters for popular and recently added movies
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get recentlyAddedMovies => _recentlyAddedMovies;
  bool get loading => _loading;

  // Method to fetch movies (update this with your API logic)
  Future<void> fetchMovies() async {
    _loading = true;
    notifyListeners();

    // Fetch popular movies
    final popularResponse = await http.get(Uri.parse('YOUR_POPULAR_MOVIES_API_URL'));
    // Assuming you have a method to parse the response
    _popularMovies = parseMovies(popularResponse.body); // Implement parseMovies according to your needs

    // Fetch recently added movies
    final recentlyAddedResponse = await http.get(Uri.parse('YOUR_RECENTLY_ADDED_MOVIES_API_URL'));
    _recentlyAddedMovies = parseMovies(recentlyAddedResponse.body); // Implement parseMovies accordingly

    _loading = false;
    notifyListeners();
  }

  // Dummy parsing method, replace with your actual implementation
  List<Movie> parseMovies(String responseBody) {
    // Parse your response and return a list of Movie objects
    // This is just an example
    return [];
  }
}
