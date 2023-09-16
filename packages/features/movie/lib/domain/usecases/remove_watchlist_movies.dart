import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../repositories/movie_repository.dart';

class RemoveWatchlistMovies {
  final MovieRepository repository;

  RemoveWatchlistMovies(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlistMovies(movie);
  }
}
