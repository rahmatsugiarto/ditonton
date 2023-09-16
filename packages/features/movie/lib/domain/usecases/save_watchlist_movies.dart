import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import '../repositories/movie_repository.dart';

class SaveWatchlistMovies {
  final MovieRepository repository;

  SaveWatchlistMovies(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlistMovies(movie);
  }
}
