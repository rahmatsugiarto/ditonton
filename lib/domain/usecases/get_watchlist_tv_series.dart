import 'package:dartz/dartz.dart';
import '../entities/tv_series.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class GetWatchlistTvSeries {
  final Repository _repository;

  GetWatchlistTvSeries(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
}
