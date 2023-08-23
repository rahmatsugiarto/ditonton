import 'package:dartz/dartz.dart';
import '../entities/tv_series.dart';

import '../../common/failure.dart';
import '../repositories/repository.dart';

class SearchTvSeries {
  final Repository repository;

  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
