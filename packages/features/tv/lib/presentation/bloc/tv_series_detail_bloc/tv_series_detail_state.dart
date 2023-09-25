part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailState extends Equatable {
  final ViewData<TvSeriesDetail> tvSeriesDetailState;
  final ViewData<List<TvSeries>> tvRecommendationsState;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final bool isErrorWatchlist;

  const TvSeriesDetailState({
    required this.tvSeriesDetailState,
    required this.tvRecommendationsState,
    required this.isAddedToWatchlist,
    required this.watchlistMessage,
    required this.isErrorWatchlist,
  });

  TvSeriesDetailState copyWith({
    ViewData<TvSeriesDetail>? tvSeriesDetailState,
    ViewData<List<TvSeries>>? tvSeriesRecommendationsState,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
    bool? isErrorWatchlist,
  }) {
    return TvSeriesDetailState(
      tvSeriesDetailState: tvSeriesDetailState ?? this.tvSeriesDetailState,
      tvRecommendationsState:
          tvSeriesRecommendationsState ?? this.tvRecommendationsState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isErrorWatchlist: isErrorWatchlist ?? this.isErrorWatchlist,
    );
  }

  @override
  List<Object?> get props => [
        tvSeriesDetailState,
        tvRecommendationsState,
        isAddedToWatchlist,
        watchlistMessage,
        isErrorWatchlist,
      ];
}
