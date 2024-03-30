import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter/foundation.dart';

import '../../common/enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/search_movies.dart';
import '../../domain/usecases/search_tv_series.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvSeries searchTvSeries;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTvSeries,
  });

  RequestState _searchMovieState = RequestState.Initial;
  RequestState get searchMovieState => _searchMovieState;

  List<Movie> _searchMovieResult = [];
  List<Movie> get searchMovieResult => _searchMovieResult;

  List<TvSeries> _searchTvResult = [];
  List<TvSeries> get searchTvResult => _searchTvResult;

  String _message = '';
  String get message => _message;

  ChipsFilter _filter = ChipsFilter.Movie;
  ChipsFilter get filter => _filter;

  Future<void> fetchMovieSearch(String query) async {
    _searchMovieState = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _searchMovieState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        if (data.isEmpty) {
          _searchMovieState = RequestState.Empty;
        } else {
          _searchMovieResult = data;
          _searchMovieState = RequestState.Loaded;
        }
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvSeriesSearch(String query) async {
    _searchMovieState = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _searchMovieState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        if (data.isEmpty) {
          _searchMovieState = RequestState.Empty;
        } else {
          _searchTvResult = data;
          _searchMovieState = RequestState.Loaded;
        }

        notifyListeners();
      },
    );
  }

  void setFilter(ChipsFilter filter) {
    _filter = filter;
    notifyListeners();
  }
}
