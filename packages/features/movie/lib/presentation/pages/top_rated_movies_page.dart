import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc/top_rated_movies_event.dart';
import 'package:shared_dependencies/bloc/bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (context, state) {
            final status = state.topRatedMoviesState.status;
            if (status.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (status.isHasData) {
              final movies = state.topRatedMoviesState.data ?? <Movie>[];
              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCard(movie);
                },
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(state.topRatedMoviesState.message),
              );
            }
          },
        ),
      ),
    );
  }
}
