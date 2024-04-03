import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc/popular_movies_event.dart';
import 'package:shared_dependencies/bloc/bloc.dart';

import '../bloc/popular_movies_bloc/popular_movies_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularMoviesBloc>().add(FetchPopularMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            final status = state.popularMoviesState.status;
            if (status.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (status.isHasData) {
              final data = state.popularMoviesState.data ?? <Movie>[];
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final movie = data[index];
                  return MovieCard(movie);
                },
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(state.popularMoviesState.message),
              );
            }
          },
        ),
      ),
    );
  }
}
