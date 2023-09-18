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
            searchState: RequestState.Empty,
            searchMovieResult: [],
            searchTvResult: [],
            message: "",
            filter: ChipsFilter.Movie,
          ),
        ) {
    on<OnQueryChangedMovie>(
      (event, emit) async {
        final query = event.query;

        emit(state.copyWith(signInState: RequestState.Loading));
        final result = await searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(state.copyWith(
              message: failure.message,
              signInState: RequestState.Error,
            ));
          },
          (data) {
            emit(state.copyWith(
              searchMovieResult: data,
              signInState: RequestState.Loaded,
            ));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<OnQueryChangedTv>(
      (event, emit) async {
        final query = event.query;
        emit(state.copyWith(signInState: RequestState.Loading));
        final result = await searchTvSeries.execute(query);

        result.fold(
          (failure) {
            emit(state.copyWith(
              message: failure.message,
              signInState: RequestState.Error,
            ));
          },
          (data) {
            emit(state.copyWith(
              searchTvResult: data,
              signInState: RequestState.Loaded,
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
