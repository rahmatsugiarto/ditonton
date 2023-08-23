import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../repositories/repository.dart';

import '../entities/tv_series.dart';

class GetNowPlayingTvSeries {
  final Repository repository;

  GetNowPlayingTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getNowPlayingTvSeries();
  }
}
