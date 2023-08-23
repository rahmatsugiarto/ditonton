import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

import '../../common/failure.dart';
import '../entities/movie.dart';
import '../entities/movie_detail.dart';
import '../entities/tv_series.dart';
import '../entities/tv_series_season_detail.dart';

abstract class Repository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlistMovies(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlistMovies(MovieDetail movie);
  Future<bool> isAddedToWatchlistMovies(int id);
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();

  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, String>> saveWatchlistTvSeries(
    TvSeriesDetail tvSeries,
  );
  Future<Either<Failure, String>> removeWatchlistTvSeries(
    TvSeriesDetail tvSeries,
  );
  Future<bool> isAddedToWatchlistTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
  Future<Either<Failure, TvSeriesSeasonDetail>> getTvSeriesSeasonDetail(
    int id,
    int season,
  );
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
}
