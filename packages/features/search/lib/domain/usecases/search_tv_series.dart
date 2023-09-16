import 'package:core/core.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

import '../repositories/search_repository.dart';

class SearchTvSeries {
  final SearchRepository repository;

  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
