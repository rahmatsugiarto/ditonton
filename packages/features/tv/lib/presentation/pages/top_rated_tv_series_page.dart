import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/bloc/bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_series_bloc/top_rated_tv_series_event.dart';

import '../bloc/top_rated_tv_series_bloc/top_rated_tv_series_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedTvSeriesBloc>().add(FetchTopRatedMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
          builder: (context, state) {
            final status = state.topRatedTvSeriesState.status;
            if (status.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (status.isHasData) {
              final listTopRated =
                  state.topRatedTvSeriesState.data ?? <TvSeries>[];
              return ListView.builder(
                itemCount: listTopRated.length,
                itemBuilder: (context, index) {
                  final topRated = listTopRated[index];
                  return TvSeriesCard(topRated);
                },
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(state.topRatedTvSeriesState.message),
              );
            }
          },
        ),
      ),
    );
  }
}
