import 'dart:convert';

import 'package:core/core.dart';

abstract class SearchRemoteDataSource {
  Future<List<MovieModel>> searchMovies(String query);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final SSLPinningClient client;

  SearchRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
