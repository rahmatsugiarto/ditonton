import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/bloc/bloc.dart';
import 'package:shared_dependencies/cached_network_image/cached_network_image.dart';
import 'package:tv/tv.dart';

import '../bloc/tv_series_list_bloc/tv_series_list_event.dart';

class HomeTvSeriesPage extends StatefulWidget {
  @override
  _HomeTvSeriesPageState createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesListBloc>()
        ..add(FetchNowPlayingTvSeries())
        ..add(FetchPopularTvSeries())
        ..add(FetchTopRatedTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MOVIE_HOME_ROUTE_NAME,
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.tv_outlined),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_ROUTE);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                  builder: (context, state) {
                final status = state.nowPlayingTvState.status;
                if (status.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status.isHasData) {
                  return TvSeriesList(
                    state.nowPlayingTvState.data ?? <TvSeries>[],
                  );
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  TV_POPULAR_ROUTE,
                ),
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                  builder: (context, state) {
                final status = state.popularTvState.status;
                if (status.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status.isHasData) {
                  return TvSeriesList(
                    state.popularTvState.data ?? <TvSeries>[],
                  );
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  TV_TOP_RATED_ROUTE,
                ),
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                  builder: (context, state) {
                final status = state.topRatedTvState.status;
                if (status.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status.isHasData) {
                  return TvSeriesList(
                    state.topRatedTvState.data ?? <TvSeries>[],
                  );
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> listTvSeries;

  TvSeriesList(this.listTvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = listTvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_DETAIL_ROUTE,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: listTvSeries.length,
      ),
    );
  }
}
