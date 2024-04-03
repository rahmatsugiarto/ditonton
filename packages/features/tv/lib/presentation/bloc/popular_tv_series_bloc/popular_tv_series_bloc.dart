import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../../../domain/usecases/get_popular_tv_series.dart';
import 'popular_tv_series_event.dart';

part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesBloc({
    required this.getPopularTvSeries,
  }) : super(PopularTvSeriesState(
          popularTvSeriesState: ViewData.initial(),
        )) {
    on<FetchPopularTvSeries>((event, emit) async {
      emit(state.copyWith(popularTvSeriesState: ViewData.loading()));
      final result = await getPopularTvSeries.execute();

      result.fold((failure) {
        emit(state.copyWith(
          popularTvSeriesState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          popularTvSeriesState: ViewData.loaded(data: data),
        ));
      });
    });
  }
}
