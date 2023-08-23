import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/enum.dart';
import '../provider/movie_search_notifier.dart';
import '../widgets/movie_card_list.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

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
            Consumer<MovieSearchNotifier>(builder: (context, data, child) {
              return TextField(
                controller: controllerSearch,
                onSubmitted: (query) {
                  if (data.filter == ChipsFilter.Movie) {
                    data.fetchMovieSearch(query);
                  } else {
                    data.fetchTvSeriesSearch(query);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              );
            }),
            SizedBox(height: 16),
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                return Row(
                  children: [
                    FilterChip(
                      label: Text("Movie"),
                      selectedColor: kPrussianBlue,
                      selected: data.filter == ChipsFilter.Movie,
                      onSelected: (_) {
                        data.setFilter(ChipsFilter.Movie);
                        controllerSearch.clear();
                      },
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    FilterChip(
                      label: Text("Tv Series"),
                      selectedColor: kPrussianBlue,
                      selected: data.filter == ChipsFilter.TvSeries,
                      onSelected: (_) {
                        data.setFilter(ChipsFilter.TvSeries);
                        controllerSearch.clear();
                      },
                    ),
                  ],
                );
              },
            ),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                if (data.searchMovieState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.searchMovieState == RequestState.Loaded) {
                  return Builder(builder: (context) {
                    final result = data.searchMovieResult;

                    if (data.filter == ChipsFilter.Movie) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final movie = data.searchMovieResult[index];
                            return MovieCard(movie);
                          },
                          itemCount: result.length,
                        ),
                      );
                    } else {
                      final result = data.searchTvResult;

                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final tvSeries = data.searchTvResult[index];
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
