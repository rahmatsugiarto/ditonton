import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/enum.dart';
import '../../common/utils.dart';
import '../provider/watchlist_movie_notifier.dart';
import '../widgets/movie_card_list.dart';
import '../widgets/tv_series_card_list.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware, TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _tabController.dispose();
    super.dispose();
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        bottom: TabBar(
          indicatorColor: kMikadoYellow,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "Movie",
            ),
            Tab(
              text: "TV Series",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          //Watchlist Movie
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WatchlistMovieNotifier>(
              builder: (context, data, child) {
                if (data.watchlistMovieState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.watchlistMovieState == RequestState.Loaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = data.watchlistMovies[index];
                      return MovieCard(movie);
                    },
                    itemCount: data.watchlistMovies.length,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(data.message),
                  );
                }
              },
            ),
          ),
          //Watchlist TV
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WatchlistMovieNotifier>(
              builder: (context, data, child) {
                if (data.watchlistTvState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.watchlistTvState == RequestState.Loaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final watchlistTv = data.watchlistTv[index];
                      return TvSeriesCard(watchlistTv);
                    },
                    itemCount: data.watchlistTv.length,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(data.message),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
