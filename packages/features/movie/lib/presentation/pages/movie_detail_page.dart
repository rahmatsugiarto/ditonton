import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/bloc/bloc.dart';
import 'package:shared_dependencies/cached_network_image/cached_network_image.dart';
import 'package:shared_dependencies/flutter_rating_bar/flutter_rating_bar.dart';

import '../../movie.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>()
        ..add(FetchMovieDetail(id: widget.id))
        ..add(FetchMovieRecommendation(id: widget.id))
        ..add(LoadWatchlistStatus(id: widget.id));
    });
  }

  void addWatchlist(MovieDetail movie) {
    context.read<MovieDetailBloc>().add(AddWatchlist(movie: movie));
  }

  void removeFromWatchlist(MovieDetail movie) {
    context.read<MovieDetailBloc>().add(RemoveFromWatchlist(movie: movie));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
        listener: (BuildContext context, MovieDetailState state) {
          final message = state.watchlistMessage;

          if (message == MovieDetailBloc.watchlistAddSuccessMessage) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          }

          if (message == MovieDetailBloc.watchlistRemoveSuccessMessage) {
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
          final status = state.movieDetailState.status;
          if (status.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (status.isHasData) {
            final movie = state.movieDetailState.data ?? MovieDetail();
            return SafeArea(
              child: DetailContent(
                movie: movie,
                isAddedWatchlist: state.isAddedToWatchlist,
                onBtnWatchlist: () {
                  if (state.isAddedToWatchlist) {
                    removeFromWatchlist(movie);
                  } else {
                    addWatchlist(movie);
                  }
                },
              ),
            );
          } else {
            return Text(state.movieDetailState.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final bool isAddedWatchlist;
  final Function() onBtnWatchlist;

  DetailContent({
    required this.movie,
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

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                              movie.title,
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
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieDetailBloc, MovieDetailState>(
                              builder: (context, state) {
                                final status =
                                    state.movieRecommendationsState.status;
                                if (status.isLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (status.isError) {
                                  return Text(
                                      state.movieRecommendationsState.message);
                                } else if (status.isHasData) {
                                  final movieRecommendations =
                                      state.movieRecommendationsState.data ??
                                          <Movie>[];
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: movieRecommendations.length,
                                      itemBuilder: (context, index) {
                                        final movie =
                                            movieRecommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MOVIE_DETAIL_ROUTE,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
