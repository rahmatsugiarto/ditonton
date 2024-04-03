import 'package:core/core.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_event.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../domain/usecases/get_popular_movies.dart';

part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({
    required this.getPopularMovies,
  }) : super(PopularMoviesState(
          popularMoviesState: ViewData.initial(),
        )) {
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
  }
}
