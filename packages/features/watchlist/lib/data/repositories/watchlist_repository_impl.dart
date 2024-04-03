import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

import '../datasources/watchlist_local_data_source.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource localDataSource;

  WatchlistRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries() async {
    final result = await localDataSource.getWatchlistTvSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
