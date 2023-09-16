import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/search_movies.dart';
import '../../domain/usecases/search_tv_series.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvSeries searchTvSeries;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTvSeries,
  });

  RequestState _searchState = RequestState.Empty;
  RequestState get searchState => _searchState;

  List<Movie> _searchMovieResult = [];
  List<Movie> get searchMovieResult => _searchMovieResult;

  List<TvSeries> _searchTvResult = [];
  List<TvSeries> get searchTvResult => _searchTvResult;

  String _message = '';
  String get message => _message;

  ChipsFilter _filter = ChipsFilter.Movie;
  ChipsFilter get filter => _filter;

  Future<void> fetchMovieSearch(String query) async {
    _searchState = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _searchState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchMovieResult = data;
        _searchState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvSeriesSearch(String query) async {
    _searchState = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _searchState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchTvResult = data;
        _searchState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  void setFilter(ChipsFilter filter) {
    _filter = filter;
    notifyListeners();
  }
}
