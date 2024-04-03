import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../repositories/tv_repository.dart';

class RemoveWatchlistTvSeries {
  final TvRepository repository;

  RemoveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.removeWatchlistTvSeries(tvSeries);
  }
}
