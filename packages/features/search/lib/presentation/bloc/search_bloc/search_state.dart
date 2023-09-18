part of 'search_bloc.dart';

class SearchState extends Equatable {
  final RequestState searchState;
  final List<Movie> searchMovieResult;
  final List<TvSeries> searchTvResult;
  final String message;
  final ChipsFilter filter;

  const SearchState({
    required this.searchState,
    required this.searchMovieResult,
    required this.searchTvResult,
    required this.message,
    required this.filter,
  });

  SearchState copyWith({
    RequestState? signInState,
    List<Movie>? searchMovieResult,
    List<TvSeries>? searchTvResult,
    String? message,
    ChipsFilter? filter,
  }) {
    return SearchState(
      searchState: signInState ?? this.searchState,
      searchMovieResult: searchMovieResult ?? this.searchMovieResult,
      searchTvResult: searchTvResult ?? this.searchTvResult,
      message: message ?? this.message,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [
        searchState,
        searchMovieResult,
        searchTvResult,
        message,
        filter,
      ];
}
