import 'package:ditonton/presentation/pages/tv/episode_tv_series_page.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/constants.dart';
import 'common/utils.dart';
import 'injection.dart' as di;
import 'presentation/pages/about_page.dart';
import 'presentation/pages/movie/home_movie_page.dart';
import 'presentation/pages/movie/movie_detail_page.dart';
import 'presentation/pages/movie/popular_movies_page.dart';
import 'presentation/pages/movie/top_rated_movies_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/pages/tv/home_tv_page.dart';
import 'presentation/pages/tv/popular_tv_series_page.dart';
import 'presentation/pages/tv/top_rated_tv_series_page.dart';
import 'presentation/pages/tv/tv_series_detail_page.dart';
import 'presentation/pages/watchlist_page.dart';
import 'presentation/provider/episode_tv_series_notifiier.dart';
import 'presentation/provider/movie_detail_notifier.dart';
import 'presentation/provider/movie_list_notifier.dart';
import 'presentation/provider/search_notifier.dart';
import 'presentation/provider/popular_movies_notifier.dart';
import 'presentation/provider/popular_tv_series_notifier.dart';
import 'presentation/provider/top_rated_movies_notifier.dart';
import 'presentation/provider/top_rated_tv_series_notifier.dart';
import 'presentation/provider/tv_series_list_notifier.dart';
import 'presentation/provider/watchlist_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<EpisodeTvSeriesNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvSeriesPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case EpisodeTvPage.ROUTE_NAME:
              final args = settings.arguments as Map;
              final id = args['id'];
              final seasonNumber = args['seasonNumber'];
              return MaterialPageRoute(
                builder: (_) => EpisodeTvPage(
                  id: id,
                  seasonNumber: seasonNumber,
                ),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
