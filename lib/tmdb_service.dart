import 'dart:convert';
import 'package:http/http.dart' as http;

class TMDBService {
  final String apiKey = 'f43f0e6f3e877de4d26e3c3505c1e3f3';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<dynamic>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
