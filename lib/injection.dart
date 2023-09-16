import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/local_data_source.dart';
import 'data/datasources/remote_data_source.dart';
import 'data/repositories/repository_impl.dart';
import 'domain/repositories/repository.dart';
import 'domain/usecases/get_movie_detail.dart';
import 'domain/usecases/get_movie_recommendations.dart';
import 'domain/usecases/get_now_playing_movies.dart';
import 'domain/usecases/get_now_playing_tv_series.dart';
import 'domain/usecases/get_popular_movies.dart';
import 'domain/usecases/get_popular_tv_series.dart';
import 'domain/usecases/get_top_rated_movies.dart';
import 'domain/usecases/get_top_rated_tv_series.dart';
import 'domain/usecases/get_tv_series_detail.dart';
import 'domain/usecases/get_tv_series_recommendations.dart';
import 'domain/usecases/get_tv_series_season_detail.dart';
import 'domain/usecases/get_watchlist_movies.dart';
import 'domain/usecases/get_watchlist_status_movies.dart';
import 'domain/usecases/get_watchlist_status_tv_series.dart';
import 'domain/usecases/get_watchlist_tv_series.dart';
import 'domain/usecases/remove_watchlist_movies.dart';
import 'domain/usecases/remove_watchlist_tv_series.dart';
import 'domain/usecases/save_watchlist_movies.dart';
import 'domain/usecases/save_watchlist_tv_series.dart';
import 'domain/usecases/search_movies.dart';
import 'domain/usecases/search_tv_series.dart';
import 'presentation/provider/episode_tv_series_notifiier.dart';
import 'presentation/provider/movie_detail_notifier.dart';
import 'presentation/provider/movie_list_notifier.dart';
import 'presentation/provider/search_notifier.dart';
import 'presentation/provider/popular_movies_notifier.dart';
import 'presentation/provider/popular_tv_series_notifier.dart';
import 'presentation/provider/top_rated_movies_notifier.dart';
import 'presentation/provider/top_rated_tv_series_notifier.dart';
import 'presentation/provider/tv_series_detail_notifier.dart';
import 'presentation/provider/tv_series_list_notifier.dart';
import 'presentation/provider/watchlist_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchNotifier(
      searchMovies: locator(),
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistNotifier(
      getWatchlistMovies: locator(),
      getWatchlistTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesListNotifier(
      getNowPlayingTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesNotifier(
      getPopularTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesNotifier(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailNotifier(
      getTvSeriesRecommendations: locator(),
      getTvSeriesDetail: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => EpisodeTvSeriesNotifier(
      getTvSeriesSeasonDetail: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovies(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovies(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesSeasonDetail(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));

  // repository
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
