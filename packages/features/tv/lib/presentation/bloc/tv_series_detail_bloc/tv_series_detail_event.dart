part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  FetchTvSeriesDetail({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchTvSeriesRecommendation extends TvSeriesDetailEvent {
  final int id;

  FetchTvSeriesRecommendation({required this.id});

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeries;

  AddWatchlist({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class RemoveFromWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeries;

  RemoveFromWatchlist({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class LoadWatchlistStatus extends TvSeriesDetailEvent {
  final int id;

  LoadWatchlistStatus({required this.id});

  @override
  List<Object> get props => [id];
}
