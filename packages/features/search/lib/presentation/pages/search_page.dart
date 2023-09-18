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
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.searchState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.searchState == RequestState.Loaded) {
                  return Builder(builder: (context) {
                    final result = state.searchMovieResult;

                    if (state.filter == ChipsFilter.Movie) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final movie = state.searchMovieResult[index];
                            return MovieCard(movie);
                          },
                          itemCount: result.length,
                        ),
                      );
                    } else {
                      final result = state.searchTvResult;

                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final tvSeries = state.searchTvResult[index];
                            return TvSeriesCard(tvSeries);
                          },
                          itemCount: result.length,
                        ),
                      );
                    }
                  });
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
