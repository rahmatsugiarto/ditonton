part of 'top_rated_tv_series_bloc.dart';

class TopRatedTvSeriesState extends Equatable {
  final ViewData<List<TvSeries>> topRatedTvSeriesState;

  const TopRatedTvSeriesState({
    required this.topRatedTvSeriesState,
  });

  TopRatedTvSeriesState copyWith({
    ViewData<List<TvSeries>>? topRatedTvSeriesState,
  }) {
    return TopRatedTvSeriesState(
      topRatedTvSeriesState:
          topRatedTvSeriesState ?? this.topRatedTvSeriesState,
    );
  }

  @override
  List<Object?> get props => [topRatedTvSeriesState];
}
