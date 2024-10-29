import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../provider/movie_provider.dart';

class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Movies')),
      body: movieProvider.loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            // Carousel for Popular Movies
            if (movieProvider.popularMovies.isNotEmpty)
              CarouselSlider.builder(
                itemCount: movieProvider.popularMovies.length,
                itemBuilder: (context, index, realIdx) {
                  final movie = movieProvider.popularMovies[index];
                  return Card(
                    child: Column(
                      children: [
                        movie.posterPath != null
                            ? Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          fit: BoxFit.cover,
                        )
                            : Container(
                          height: 200, // Fallback height for empty poster
                          color: Colors.grey,
                          child: Center(child: Text('No Image')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  initialPage: 0,
                ),
              )
            else
             const Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'No popular movies available.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            SizedBox(height: 20),
            // Recently Added Movies Section
            const  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Recently Added Movies',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            if (movieProvider.recentlyAddedMovies.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Prevent scrolling
                itemCount: movieProvider.recentlyAddedMovies.length,
                itemBuilder: (context, index) {
                  final movie = movieProvider.recentlyAddedMovies[index];
                  return ListTile(
                    title: Text(movie.title),
                    leading: movie.posterPath != null
                        ? Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}')
                        : null,
                  );
                },
              )
            else
              const Padding(
                padding:  EdgeInsets.all(16.0),
                child: Text(
                  'No recently added movies available.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => movieProvider.fetchMovies(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
