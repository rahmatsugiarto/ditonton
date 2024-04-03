part of 'popular_tv_series_bloc.dart';

class PopularTvSeriesState extends Equatable {
  final ViewData<List<TvSeries>> popularTvSeriesState;

  const PopularTvSeriesState({
    required this.popularTvSeriesState,
  });

  PopularTvSeriesState copyWith({
    ViewData<List<TvSeries>>? popularTvSeriesState,
  }) {
    return PopularTvSeriesState(
      popularTvSeriesState: popularTvSeriesState ?? this.popularTvSeriesState,
    );
  }

  @override
  List<Object?> get props => [
        popularTvSeriesState,
      ];
}
