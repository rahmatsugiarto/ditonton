import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/bloc/bloc.dart';
import 'package:shared_dependencies/cached_network_image/cached_network_image.dart';

import '../bloc/episode_tv_series_bloc/episode_tv_series_bloc.dart';
import '../bloc/episode_tv_series_bloc/episode_tv_series_event.dart';

class EpisodeTvPage extends StatefulWidget {
  final int id;
  final int seasonNumber;

  EpisodeTvPage({
    required this.id,
    required this.seasonNumber,
  });

  @override
  _EpisodeTvPageState createState() => _EpisodeTvPageState();
}

class _EpisodeTvPageState extends State<EpisodeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<EpisodeTvSeriesBloc>().add(FetchEpisodeTvSeries(
            id: widget.id,
            season: widget.seasonNumber,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Episode"),
      ),
      body: BlocBuilder<EpisodeTvSeriesBloc, EpisodeTvSeriesState>(
        builder: (context, state) {
          final status = state.episodeTvSeriesState.status;
          if (status.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (status.isHasData) {
            final listEpisode = state.episodeTvSeriesState.data ?? <Episode>[];
            return ListView.builder(
                shrinkWrap: true,
                itemCount: listEpisode.length,
                itemBuilder: (context, i) {
                  var episode = listEpisode[i];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            height: 100,
                            width: 140,
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      episode.episodeNumber.toString(),
                                      style: kSubtitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            episode.name,
                                            style: kSubtitle,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(episode.airDate),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  episode.overview,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Text(state.episodeTvSeriesState.message);
          }
        },
      ),
    );
  }
}
