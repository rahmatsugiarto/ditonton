import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/repository.dart';

class GetMovieDetail {
  final Repository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
