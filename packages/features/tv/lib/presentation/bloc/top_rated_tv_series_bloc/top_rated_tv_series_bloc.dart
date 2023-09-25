import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../domain/usecases/get_top_rated_tv_series.dart';
import 'top_rated_tv_series_event.dart';

part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc({
    required this.getTopRatedTvSeries,
  }) : super(TopRatedTvSeriesState(
          topRatedTvSeriesState: ViewData.initial(),
        )) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(state.copyWith(topRatedTvSeriesState: ViewData.loading()));
      final result = await getTopRatedTvSeries.execute();

      result.fold((failure) {
        emit(state.copyWith(
          topRatedTvSeriesState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          topRatedTvSeriesState: ViewData.loaded(data: data),
        ));
      });
    });
  }
}
