import 'package:core/core.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlistMovies(MovieTable movie);
  Future<String> removeWatchlistMovies(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistMovies(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlistMovies(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseExp(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistMovies(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlistMovies(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseExp(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }
}
