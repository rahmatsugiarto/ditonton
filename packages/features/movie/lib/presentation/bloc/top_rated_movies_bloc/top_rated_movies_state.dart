part of 'top_rated_movies_bloc.dart';

class TopRatedMoviesState extends Equatable {
  final ViewData<List<Movie>> topRatedMoviesState;

  const TopRatedMoviesState({
    required this.topRatedMoviesState,
  });

  TopRatedMoviesState copyWith({
    ViewData<List<Movie>>? topRatedMoviesState,
  }) {
    return TopRatedMoviesState(
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
    );
  }

  @override
  List<Object?> get props => [
        topRatedMoviesState,
      ];
}
