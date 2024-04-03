import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../movie.dart';
import 'movie_list_event.dart';

part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListState(
          nowPlayingState: ViewData.initial(),
          popularMoviesState: ViewData.initial(),
          topRatedMoviesState: ViewData.initial(),
        )) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(state.copyWith(nowPlayingState: ViewData.loading()));
      final result = await getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(state.copyWith(
          nowPlayingState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          nowPlayingState: ViewData.loaded(data: data),
        ));
      });
    });

    on<FetchPopularMovies>((event, emit) async {
      emit(state.copyWith(popularMoviesState: ViewData.loading()));
      final result = await getPopularMovies.execute();

      result.fold((failure) {
        emit(state.copyWith(
          popularMoviesState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          popularMoviesState: ViewData.loaded(data: data),
        ));
      });
    });

    on<FetchTopRatedMovies>((event, emit) async {
      emit(state.copyWith(topRatedMoviesState: ViewData.loading()));
      final result = await getTopRatedMovies.execute();

      result.fold((failure) {
        emit(state.copyWith(
          topRatedMoviesState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          topRatedMoviesState: ViewData.loaded(data: data),
        ));
      });
    });
  }
}
