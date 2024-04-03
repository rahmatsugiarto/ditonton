part of 'tv_series_list_bloc.dart';

class TvSeriesListState extends Equatable {
  final ViewData<List<TvSeries>> nowPlayingTvState;
  final ViewData<List<TvSeries>> popularTvState;
  final ViewData<List<TvSeries>> topRatedTvState;

  const TvSeriesListState({
    required this.nowPlayingTvState,
    required this.popularTvState,
    required this.topRatedTvState,
  });

  TvSeriesListState copyWith({
    ViewData<List<TvSeries>>? nowPlayingTvState,
    ViewData<List<TvSeries>>? popularTvState,
    ViewData<List<TvSeries>>? topRatedTvState,
  }) {
    return TvSeriesListState(
      nowPlayingTvState: nowPlayingTvState ?? this.nowPlayingTvState,
      popularTvState: popularTvState ?? this.popularTvState,
      topRatedTvState: topRatedTvState ?? this.topRatedTvState,
    );
  }

  @override
  List<Object?> get props => [
        nowPlayingTvState,
        popularTvState,
        topRatedTvState,
      ];
}
