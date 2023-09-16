import 'package:flutter/foundation.dart';

import '../../common/enum.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_watchlist_movies.dart';
import '../../domain/usecases/get_watchlist_tv_series.dart';

class WatchlistNotifier extends ChangeNotifier {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistNotifier({
    required this.getWatchlistMovies,
    required this.getWatchlistTvSeries,
  });

  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistMovieState = RequestState.Empty;
  RequestState get watchlistMovieState => _watchlistMovieState;

  var _watchlistTv = <TvSeries>[];
  List<TvSeries> get watchlistTv => _watchlistTv;

  var _watchlistTvState = RequestState.Empty;
  RequestState get watchlistTvState => _watchlistTvState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistMovies() async {
    _watchlistMovieState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistMovieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistMovieState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTv() async {
    _watchlistTvState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        _watchlistTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _watchlistTvState = RequestState.Loaded;
        _watchlistTv = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
