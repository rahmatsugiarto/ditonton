import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:tv/presentation/bloc/episode_tv_series_bloc/episode_tv_series_event.dart';

import '../../../domain/usecases/get_tv_series_season_detail.dart';

part 'episode_tv_series_state.dart';

class EpisodeTvSeriesBloc
    extends Bloc<EpisodeTvSeriesEvent, EpisodeTvSeriesState> {
  final GetTvSeriesSeasonDetail getTvSeriesSeasonDetail;

  EpisodeTvSeriesBloc({
    required this.getTvSeriesSeasonDetail,
  }) : super(EpisodeTvSeriesState(
          episodeTvSeriesState: ViewData.initial(),
        )) {
    on<FetchEpisodeTvSeries>((event, emit) async {
      emit(state.copyWith(episodeTvSeriesState: ViewData.loading()));
      final result = await getTvSeriesSeasonDetail.execute(
        event.id,
        event.season,
      );

      result.fold((failure) {
        emit(state.copyWith(
          episodeTvSeriesState: ViewData.error(message: failure.message),
        ));
      }, (data) {
        emit(state.copyWith(
          episodeTvSeriesState: ViewData.loaded(data: data.episodes),
        ));
      });
    });
  }
}
