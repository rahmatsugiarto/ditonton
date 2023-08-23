import '../repositories/repository.dart';

class GetWatchListStatusMovies {
  final Repository repository;

  GetWatchListStatusMovies(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistMovies(id);
  }
}
