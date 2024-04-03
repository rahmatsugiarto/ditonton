import 'package:core/core.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

abstract class TvRepository {
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
  Future<Either<Failure, TvSeriesSeasonDetail>> getTvSeriesSeasonDetail(
    int id,
    int season,
  );
}
