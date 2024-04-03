import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../repositories/tv_repository.dart';

class GetTvSeriesSeasonDetail {
  final TvRepository repository;

  GetTvSeriesSeasonDetail(this.repository);

  Future<Either<Failure, TvSeriesSeasonDetail>> execute(int id, int season) {
    return repository.getTvSeriesSeasonDetail(id, season);
  }
}
