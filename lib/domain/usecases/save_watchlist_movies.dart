import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/repository.dart';

class SaveWatchlistMovies {
  final Repository repository;

  SaveWatchlistMovies(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlistMovies(movie);
  }
}
