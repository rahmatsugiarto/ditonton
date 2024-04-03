import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../tv.dart';
import 'tv_series_list_event.dart';

part 'tv_series_list_state.dart';

class TvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesListBloc({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  }) : super(TvSeriesListState(
          nowPlayingTvState: ViewData.initial(),
          popularTvState: ViewData.initial(),
          topRatedTvState: ViewData.initial(),
        )) {
    on<FetchNowPlayingTvSeries>((event, emit) async {
      emit(state.copyWith(nowPlayingTvState: ViewData.loading()));
      final result = await getNowPlayingTvSeries.execute();

      result.fold((failure) {
        emit(state.copyWith(
          nowPlayingTvState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          nowPlayingTvState: ViewData.loaded(data: data),
        ));
      });
    });

    on<FetchPopularTvSeries>((event, emit) async {
      emit(state.copyWith(popularTvState: ViewData.loading()));
      final result = await getPopularTvSeries.execute();

      result.fold((failure) {
        emit(state.copyWith(
          popularTvState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          popularTvState: ViewData.loaded(data: data),
        ));
      });
    });

    on<FetchTopRatedTvSeries>((event, emit) async {
      emit(state.copyWith(topRatedTvState: ViewData.loading()));
      final result = await getTopRatedTvSeries.execute();

      result.fold((failure) {
        emit(state.copyWith(
          topRatedTvState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          topRatedTvState: ViewData.loaded(data: data),
        ));
      });
    });
  }
}
