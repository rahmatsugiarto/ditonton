import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class GetTvSeriesRecommendations {
  final Repository repository;

  GetTvSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
