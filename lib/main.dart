import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_provider.dart';
import 'movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        title: 'Movie Recommendation App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MovieListScreen(),
      ),
    );
  }
}

class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Popular Movies')),
      body: movieProvider.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: movieProvider.movies.length,
        itemBuilder: (context, index) {
          final movie = movieProvider.movies[index];
          return ListTile(
            title: Text(movie.title),
            leading: movie.posterPath != null
                ? Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}')
                : null,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => movieProvider.fetchMovies(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
