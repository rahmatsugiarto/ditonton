import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();

  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
}
