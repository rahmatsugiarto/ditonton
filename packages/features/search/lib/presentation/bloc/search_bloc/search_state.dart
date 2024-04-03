part of 'search_bloc.dart';

class SearchState extends Equatable {
  final ViewData<List<Movie>> searchMovieState;
  final ViewData<List<TvSeries>> searchTvState;
  final ChipsFilter filter;

  const SearchState({
    required this.searchMovieState,
    required this.searchTvState,
    required this.filter,
  });

  SearchState copyWith({
    ViewData<List<Movie>>? searchMovieState,
    ViewData<List<TvSeries>>? searchTvState,
    ChipsFilter? filter,
  }) {
    return SearchState(
      searchMovieState: searchMovieState ?? this.searchMovieState,
      searchTvState: searchTvState ?? this.searchTvState,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [
        searchMovieState,
        searchTvState,
        filter,
      ];
}
