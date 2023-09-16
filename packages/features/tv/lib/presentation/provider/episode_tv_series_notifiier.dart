import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_tv_series_season_detail.dart';

class EpisodeTvSeriesNotifier extends ChangeNotifier {
  final GetTvSeriesSeasonDetail getTvSeriesSeasonDetail;

  EpisodeTvSeriesNotifier({
    required this.getTvSeriesSeasonDetail,
  });

  late TvSeriesSeasonDetail _tvSeriesSeason;
  TvSeriesSeasonDetail get tvSeriesSeason => _tvSeriesSeason;

  RequestState _tvSeriesSeasonState = RequestState.Empty;
  RequestState get tvSeriesSeasonState => _tvSeriesSeasonState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesSeasonDetail(int id, int season) async {
    _tvSeriesSeasonState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesSeasonDetail.execute(id, season);
    detailResult.fold(
      (failure) {
        _tvSeriesSeasonState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesSeason) {
        _tvSeriesSeason = tvSeriesSeason;
        _tvSeriesSeasonState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
