import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/cached_network_image/cached_network_image.dart';
import 'package:shared_dependencies/provider/provider.dart';

import '../provider/episode_tv_series_notifiier.dart';

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
      Provider.of<EpisodeTvSeriesNotifier>(context, listen: false)
          .fetchTvSeriesSeasonDetail(
        widget.id,
        widget.seasonNumber,
      );
    });
    log(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Episode"),
      ),
      body: Consumer<EpisodeTvSeriesNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesSeasonState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesSeasonState == RequestState.Loaded) {
            final tvSeriesSeasonDetail = provider.tvSeriesSeason;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: tvSeriesSeasonDetail.episodes.length,
                itemBuilder: (context, i) {
                  var episode = tvSeriesSeasonDetail.episodes[i];
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
            return Text(provider.message);
          }
        },
      ),
    );
  }
}
