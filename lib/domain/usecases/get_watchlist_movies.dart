import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/repository.dart';

class GetWatchlistMovies {
  final Repository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
