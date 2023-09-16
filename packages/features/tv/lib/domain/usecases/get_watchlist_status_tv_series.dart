import '../repositories/tv_repository.dart';

class GetWatchListStatusTvSeries {
  final TvRepository repository;

  GetWatchListStatusTvSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTvSeries(id);
  }
}
