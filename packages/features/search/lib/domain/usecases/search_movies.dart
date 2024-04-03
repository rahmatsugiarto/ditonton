import 'package:core/core.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

import '../repositories/search_repository.dart';

class SearchMovies {
  final SearchRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
