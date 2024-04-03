import 'package:core/core.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Movie>>> searchMovies(String query);

  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
}
