import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/bloc/bloc.dart';
import 'package:shared_dependencies/cached_network_image/cached_network_image.dart';

import '../bloc/movie_list_bloc/movie_list_bloc.dart';
import '../bloc/movie_list_bloc/movie_list_event.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieListBloc>()
        ..add(FetchNowPlayingMovies())
        ..add(FetchPopularMovies())
        ..add(FetchTopRatedMovies());
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv_outlined),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  TV_HOME_ROUTE_NAME,
                  (route) => false,
                );
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
        title: Text('Movie'),
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
              BlocBuilder<MovieListBloc, MovieListState>(
                  builder: (context, state) {
                final status = state.nowPlayingState.status;
                if (status.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status.isError) {
                  return Text(state.nowPlayingState.message);
                } else if (status.isHasData) {
                  return MovieList(state.nowPlayingState.data ?? []);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, MOVIE_POPULAR_ROUTE),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                  builder: (context, state) {
                final status = state.popularMoviesState.status;
                if (status.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status.isError) {
                  return Text(state.popularMoviesState.message);
                } else if (status.isHasData) {
                  return MovieList(state.popularMoviesState.data ?? []);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, MOVIE_TOP_RATED_ROUTE),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                  builder: (context, state) {
                final status = state.topRatedMoviesState.status;
                if (status.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (status.isError) {
                  return Text(state.topRatedMoviesState.message);
                } else if (status.isHasData) {
                  return MovieList(state.topRatedMoviesState.data ?? []);
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
