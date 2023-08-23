import '../repositories/repository.dart';

class GetWatchListStatusTvSeries {
  final Repository repository;

  GetWatchListStatusTvSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTvSeries(id);
  }
}
