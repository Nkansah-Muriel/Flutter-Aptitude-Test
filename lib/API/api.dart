import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:moviemot/API/key.dart';
import 'package:moviemot/model/movies.dart';

class Api {
  final popularMoviesUrl =
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&page=4";
  final upComingMoviesUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&page=4";
  final topRatedMoviesUrl =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&page=4";

  Future<List<Movies>> getPopularMovies() async {
    final response = await http.get(Uri.parse(popularMoviesUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movies> movies = data.map((movie) => Movies.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load Popular Movies');
    }
  }

  Future<List<Movies>> getUpComingMovies() async {
    final response = await http.get(Uri.parse(upComingMoviesUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movies> movies = data.map((movie) => Movies.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load Up Coming Movies');
    }
  }

  Future<List<Movies>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(topRatedMoviesUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movies> movies = data.map((movie) => Movies.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load Up Top Rated Movies');
    }
  }

  Future<List<Movies>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Debug log

      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((movie) => Movies.fromMap(movie))
          .toList();
    } else {
      print('Failed to load movies: ${response.reasonPhrase}'); // Debug log
      throw Exception('Failed to load movies');
    }
  }
}
