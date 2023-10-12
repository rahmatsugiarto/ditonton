part of 'watchlist_bloc.dart';

class WatchlistState extends Equatable {
  final ViewData<List<Movie>> watchlistMovieState;
  final ViewData<List<TvSeries>> watchlistTvState;

  const WatchlistState({
    required this.watchlistMovieState,
    required this.watchlistTvState,
  });

  WatchlistState copyWith({
    ViewData<List<Movie>>? watchlistMovieState,
    ViewData<List<TvSeries>>? watchlistTvState,
  }) {
    return WatchlistState(
      watchlistMovieState: watchlistMovieState ?? this.watchlistMovieState,
      watchlistTvState: watchlistTvState ?? this.watchlistTvState,
    );
  }

  @override
  List<Object?> get props => [
        watchlistMovieState,
        watchlistTvState,
      ];
}
