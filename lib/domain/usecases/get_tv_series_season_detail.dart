import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_season_detail.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class GetTvSeriesSeasonDetail {
  final Repository repository;

  GetTvSeriesSeasonDetail(this.repository);

  Future<Either<Failure, TvSeriesSeasonDetail>> execute(int id, int season) {
    return repository.getTvSeriesSeasonDetail(id, season);
  }
}
