import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../movie.dart';
import 'top_rated_movies_event.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({
    required this.getTopRatedMovies,
  }) : super(TopRatedMoviesState(
          topRatedMoviesState: ViewData.initial(),
        )) {
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
