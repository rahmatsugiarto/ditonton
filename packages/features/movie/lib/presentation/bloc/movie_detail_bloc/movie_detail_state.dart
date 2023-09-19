part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final ViewData<MovieDetail> movieState;
  final ViewData<List<Movie>> movieRecommendationsState;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final bool isErrorWatchlist;

  const MovieDetailState({
    required this.movieState,
    required this.movieRecommendationsState,
    required this.isAddedToWatchlist,
    required this.watchlistMessage,
    required this.isErrorWatchlist,
  });

  MovieDetailState copyWith({
    MovieDetail? movie,
    ViewData<MovieDetail>? movieState,
    ViewData<List<Movie>>? movieRecommendationsState,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    bool? isErrorWatchlist,
  }) {
    return MovieDetailState(
      movieState: movieState ?? this.movieState,
      movieRecommendationsState:
          movieRecommendationsState ?? this.movieRecommendationsState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isErrorWatchlist: isErrorWatchlist ?? this.isErrorWatchlist,
    );
  }

  @override
  List<Object?> get props => [
        movieState,
        movieRecommendationsState,
        isAddedToWatchlist,
        watchlistMessage,
        isErrorWatchlist,
      ];
}
