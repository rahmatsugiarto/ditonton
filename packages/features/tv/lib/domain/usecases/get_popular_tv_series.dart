import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../repositories/tv_repository.dart';

class GetPopularTvSeries {
  final TvRepository repository;

  GetPopularTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getPopularTvSeries();
  }
}
