import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../repositories/tv_repository.dart';

class SaveWatchlistTvSeries {
  final TvRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.saveWatchlistTvSeries(tvSeries);
  }
}
