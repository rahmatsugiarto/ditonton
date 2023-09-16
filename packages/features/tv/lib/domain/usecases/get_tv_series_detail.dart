import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../repositories/tv_repository.dart';

class GetTvSeriesDetail {
  final TvRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
