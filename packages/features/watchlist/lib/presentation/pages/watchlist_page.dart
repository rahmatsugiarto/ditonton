import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/bloc/bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_bloc/watchlist_bloc.dart';

class WatchlistPage extends StatefulWidget {
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
    Future.microtask(() {
      fetchWatchlistMovies();
      fetchWatchlistTv();
    });
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
    fetchWatchlistMovies();
    fetchWatchlistTv();
  }

  void fetchWatchlistMovies() {
    context.read<WatchlistBloc>().add(FetchWatchlistMovies());
  }

  void fetchWatchlistTv() {
    context.read<WatchlistBloc>().add(FetchWatchlistTv());
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
            child: BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                final status = state.watchlistMovieState.status;
                if (status.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status.isNoData) {
                  return Center(
                    child: Text(state.watchlistMovieState.message),
                  );
                } else if (status.isHasData) {
                  final data = state.watchlistMovieState.data ?? <Movie>[];
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = data[index];
                      return MovieCard(movie);
                    },
                    itemCount: data.length,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(state.watchlistMovieState.message),
                  );
                }
              },
            ),
          ),
          //Watchlist TV
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                final status = state.watchlistTvState.status;
                if (status.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status.isNoData) {
                  return Center(
                    child: Text(state.watchlistTvState.message),
                  );
                } else if (status.isHasData) {
                  final data = state.watchlistTvState.data ?? <TvSeries>[];
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final watchlistTv = data[index];
                      return TvSeriesCard(watchlistTv);
                    },
                    itemCount: data.length,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(state.watchlistTvState.message),
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
