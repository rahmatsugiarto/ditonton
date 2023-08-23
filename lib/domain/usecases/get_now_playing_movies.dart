import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/repository.dart';

class GetNowPlayingMovies {
  final Repository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
