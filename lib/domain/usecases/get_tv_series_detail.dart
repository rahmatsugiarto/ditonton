import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_series_detail.dart';
import '../repositories/repository.dart';

class GetTvSeriesDetail {
  final Repository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
