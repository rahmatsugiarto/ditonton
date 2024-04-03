part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final ViewData<MovieDetail> movieDetailState;
  final ViewData<List<Movie>> movieRecommendationsState;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final bool isErrorWatchlist;

  const MovieDetailState({
    required this.movieDetailState,
    required this.movieRecommendationsState,
    required this.isAddedToWatchlist,
    required this.watchlistMessage,
    required this.isErrorWatchlist,
  });

  MovieDetailState copyWith({
    ViewData<MovieDetail>? movieDetailState,
    ViewData<List<Movie>>? movieRecommendationsState,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    bool? isErrorWatchlist,
  }) {
    return MovieDetailState(
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieRecommendationsState:
          movieRecommendationsState ?? this.movieRecommendationsState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isErrorWatchlist: isErrorWatchlist ?? this.isErrorWatchlist,
    );
  }

  @override
  List<Object?> get props => [
        movieDetailState,
        movieRecommendationsState,
        isAddedToWatchlist,
        watchlistMessage,
        isErrorWatchlist,
      ];
}
