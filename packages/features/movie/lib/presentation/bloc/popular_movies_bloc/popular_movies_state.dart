part of 'popular_movies_bloc.dart';

class PopularMoviesState extends Equatable {
  final ViewData<List<Movie>> popularMoviesState;

  const PopularMoviesState({
    required this.popularMoviesState,
  });

  PopularMoviesState copyWith({
    ViewData<List<Movie>>? popularMoviesState,
  }) {
    return PopularMoviesState(
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
    );
  }

  @override
  List<Object?> get props => [
        popularMoviesState,
      ];
}
