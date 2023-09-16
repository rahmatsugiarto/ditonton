import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../repositories/watchlist_repository.dart';

class GetWatchlistTvSeries {
  final WatchlistRepository _repository;

  GetWatchlistTvSeries(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
}
