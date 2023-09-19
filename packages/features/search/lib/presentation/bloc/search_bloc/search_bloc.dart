import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../search.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;
  final SearchTvSeries searchTvSeries;

  SearchBloc({
    required this.searchMovies,
    required this.searchTvSeries,
  }) : super(
          SearchState(
            searchMovieState: ViewData.initial(),
            searchTvState: ViewData.initial(),
            filter: ChipsFilter.Movie,
          ),
        ) {
    on<OnQueryChangedMovie>(
      (event, emit) async {
        final query = event.query;

        emit(state.copyWith(searchMovieState: ViewData.loading()));
        final result = await searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(state.copyWith(
              searchMovieState: ViewData.error(message: failure.message),
            ));
          },
          (data) {
            emit(state.copyWith(
              searchMovieState: ViewData.loaded(data: data),
            ));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<OnQueryChangedTv>(
      (event, emit) async {
        final query = event.query;
        emit(state.copyWith(searchTvState: ViewData.loading()));
        final result = await searchTvSeries.execute(query);

        result.fold(
          (failure) {
            emit(state.copyWith(
              searchTvState: ViewData.error(message: failure.message),
            ));
          },
          (data) {
            emit(state.copyWith(
              searchTvState: ViewData.loaded(data: data),
            ));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<FilterSearch>((event, emit) {
      emit(state.copyWith(filter: event.filter));
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
