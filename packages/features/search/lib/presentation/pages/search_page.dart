import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/bloc/bloc.dart';

import '../bloc/search_bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controllerSearch = TextEditingController();

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  void _search(String query) {
    if (context.read<SearchBloc>().state.filter == ChipsFilter.Movie) {
      context.read<SearchBloc>().add(OnQueryChangedMovie(query));
    } else {
      context.read<SearchBloc>().add(OnQueryChangedTv(query));
    }
  }

  void _setFilter(ChipsFilter filter) {
    context.read<SearchBloc>().add(FilterSearch(filter));
    controllerSearch.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controllerSearch,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return Row(
                  children: [
                    FilterChip(
                      label: Text("Movie"),
                      selectedColor: kPrussianBlue,
                      selected: state.filter == ChipsFilter.Movie,
                      onSelected: (_) => _setFilter(ChipsFilter.Movie),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    FilterChip(
                      label: Text("Tv Series"),
                      selectedColor: kPrussianBlue,
                      selected: state.filter == ChipsFilter.TvSeries,
                      onSelected: (_) => _setFilter(ChipsFilter.TvSeries),
                    ),
                  ],
                );
              },
            ),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
              if (state.filter == ChipsFilter.Movie) {
                final statusSearchMovie = state.searchMovieState.status;
                if (statusSearchMovie.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (statusSearchMovie.isNoData) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height / 3,
                          ),
                          Center(
                            child: Text(
                              state.searchMovieState.message,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (statusSearchMovie.isHasData) {
                  final dataSearchMovie =
                      state.searchMovieState.data ?? <Movie>[];
                  return Expanded(
                    child: ListView.builder(
                      itemCount: dataSearchMovie.length,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = dataSearchMovie[index];
                        return MovieCard(movie);
                      },
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              } else {
                final statusSearchTv = state.searchTvState.status;
                if (statusSearchTv.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (statusSearchTv.isNoData) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height / 3,
                          ),
                          Center(
                            child: Text(
                              state.searchTvState.message,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (statusSearchTv.isHasData) {
                  final dataSearchTv = state.searchTvState.data ?? <TvSeries>[];
                  return Expanded(
                    child: ListView.builder(
                      itemCount: dataSearchTv.length,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = dataSearchTv[index];
                        return TvSeriesCard(tv);
                      },
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
