import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/bloc/bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_series_bloc/popular_tv_series_event.dart';

import '../bloc/popular_tv_series_bloc/popular_tv_series_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvSeriesBloc>().add(FetchPopularTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
          builder: (context, state) {
            final status = state.popularTvSeriesState.status;
            {
              if (status.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (status.isHasData) {
                final listPopularTv = state.popularTvSeriesState.data ?? [];
                return ListView.builder(
                  itemCount: listPopularTv.length,
                  itemBuilder: (context, index) {
                    final popularTv = listPopularTv[index];
                    return TvSeriesCard(popularTv);
                  },
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.popularTvSeriesState.message),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
