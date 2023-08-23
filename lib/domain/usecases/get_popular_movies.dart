import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/repository.dart';

class GetPopularMovies {
  final Repository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
