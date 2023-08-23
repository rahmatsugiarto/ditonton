import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../repositories/repository.dart';

import '../entities/tv_series.dart';

class GetPopularTvSeries {
  final Repository repository;

  GetPopularTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getPopularTvSeries();
  }
}
