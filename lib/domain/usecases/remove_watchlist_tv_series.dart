import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_series_detail.dart';
import '../repositories/repository.dart';

class RemoveWatchlistTvSeries {
  final Repository repository;

  RemoveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.removeWatchlistTvSeries(tvSeries);
  }
}
