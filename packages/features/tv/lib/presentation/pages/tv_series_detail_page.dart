import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/bloc/bloc.dart';
import 'package:shared_dependencies/cached_network_image/cached_network_image.dart';
import 'package:shared_dependencies/flutter_rating_bar/flutter_rating_bar.dart';

import '../bloc/tv_series_detail_bloc/tv_series_detail_bloc.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailBloc>()
        ..add(FetchTvSeriesDetail(id: widget.id))
        ..add(FetchTvSeriesRecommendation(id: widget.id))
        ..add(LoadWatchlistStatus(id: widget.id));
    });
  }

  void addWatchlist(TvSeriesDetail tvSeries) {
    context.read<TvSeriesDetailBloc>().add(AddWatchlist(tvSeries: tvSeries));
  }

  void removeFromWatchlist(TvSeriesDetail tvSeries) {
    context
        .read<TvSeriesDetailBloc>()
        .add(RemoveFromWatchlist(tvSeries: tvSeries));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TvSeriesDetailBloc, TvSeriesDetailState>(
        listener: (BuildContext context, TvSeriesDetailState state) {
          final message = state.watchlistMessage;

          if (message == TvSeriesDetailBloc.watchlistAddSuccessMessage) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          }

          if (message == TvSeriesDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          }

          if (state.isErrorWatchlist) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(message),
                );
              },
            );
          }
        },
        builder: (context, state) {
          {
            final status = state.tvSeriesDetailState.status;
            if (status.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (status.isHasData) {
              final tvSeriesDetail =
                  state.tvSeriesDetailState.data ?? TvSeriesDetail();
              return SafeArea(
                child: DetailContent(
                  tvSeriesDetail: tvSeriesDetail,
                  isAddedWatchlist: state.isAddedToWatchlist,
                  onBtnWatchlist: () {
                    if (state.isAddedToWatchlist) {
                      removeFromWatchlist(tvSeriesDetail);
                    } else {
                      addWatchlist(tvSeriesDetail);
                    }
                  },
                ),
              );
            } else {
              return Text(state.tvSeriesDetailState.message);
            }
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeriesDetail;
  final bool isAddedWatchlist;
  final Function() onBtnWatchlist;

  DetailContent({
    required this.tvSeriesDetail,
    required this.isAddedWatchlist,
    required this.onBtnWatchlist,
  });

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: onBtnWatchlist,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvSeriesDetail.genres),
                            ),
                            Text(
                                "Total Episode: ${tvSeriesDetail.numberOfEpisodes}"),
                            Text(
                                "Total Season: ${tvSeriesDetail.numberOfSeasons}"),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: tvSeriesDetail.seasons.length,
                                itemBuilder: (context, index) {
                                  final seasonReserved =
                                      tvSeriesDetail.seasons.reversed;
                                  final season = seasonReserved.toList()[index];

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          TV_EPISODE_ROUTE,
                                          arguments: {
                                            'id': tvSeriesDetail.id,
                                            'seasonNumber': season.seasonNumber,
                                          },
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvSeriesDetailBloc,
                                TvSeriesDetailState>(
                              builder: (context, state) {
                                final status =
                                    state.tvRecommendationsState.status;
                                if (status.isLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (status.isError) {
                                  return Text(
                                      state.tvRecommendationsState.message);
                                } else if (status.isHasData) {
                                  final tvRecommendations =
                                      state.tvRecommendationsState.data ??
                                          <TvSeries>[];
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tvRecommendations.length,
                                      itemBuilder: (context, index) {
                                        final tvSeriesRecommendation =
                                            tvRecommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TV_DETAIL_ROUTE,
                                                arguments:
                                                    tvSeriesRecommendation.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvSeriesRecommendation.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
