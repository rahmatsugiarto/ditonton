import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SeasonCard extends StatelessWidget {
  final TvSeriesSeasons season;

  SeasonCard(this.season);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Card(
            child: Container(
              margin: const EdgeInsets.only(
                left: 16 + 80 + 16,
                bottom: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    season.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                  Row(
                    children: [
                      Text(
                        FormatDate.formatDateYear(season.airDate),
                      ),
                      Text(
                        ' | ',
                      ),
                      Text(
                        '${season.episodeCount} Episode',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    season.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              bottom: 16,
            ),
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${season.posterPath}',
                width: 80,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Center(
                    child: SizedBox(
                        width: 80, height: 80, child: Icon(Icons.error))),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
