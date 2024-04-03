part of 'movie_list_bloc.dart';

class MovieListState extends Equatable {
  final ViewData<List<Movie>> nowPlayingState;
  final ViewData<List<Movie>> popularMoviesState;
  final ViewData<List<Movie>> topRatedMoviesState;

  const MovieListState({
    required this.nowPlayingState,
    required this.popularMoviesState,
    required this.topRatedMoviesState,
  });

  MovieListState copyWith({
    ViewData<List<Movie>>? nowPlayingState,
    ViewData<List<Movie>>? popularMoviesState,
    ViewData<List<Movie>>? topRatedMoviesState,
  }) {
    return MovieListState(
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
    );
  }

  @override
  List<Object?> get props => [
        nowPlayingState,
        popularMoviesState,
        topRatedMoviesState,
      ];
}
