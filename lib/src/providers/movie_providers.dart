import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/src/models/actor_model.dart';

import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  final String _apiKey = '70dfd14eb8b8e0a8241a586de67a01bf';
  final String _url = 'api.themoviedb.org';
  final String _languaje = 'es-ES';

  int _popularesPage = 0;

  List<Movie> _populares = [];

  bool _loadingData = false;

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get pupularesSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void dispose() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> _execute(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final movies = Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Actor>> _executeActores(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final movies = Cast.fromJsonList(decodedData['cast']);
    return movies.actores;
  }

  Future<List<Movie>> getCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _languaje});

    return _execute(url);
  }

  Future<List<Movie>> searchCinemas(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _languaje, 'query': query});

    return _execute(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_loadingData) return [];

    _loadingData = true;

    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _languaje,
      'page': _popularesPage.toString()
    });

    final response = await _execute(url);

    _populares.addAll(response);

    pupularesSink(_populares);

    _loadingData = false;

    return response;
  }

  Future<List<Actor>> getCast(String id) async {
    final url = Uri.https(_url, '3/movie/$id/credits',
        {'api_key': _apiKey, 'language': _languaje});

    return _executeActores(url);
  }
}
