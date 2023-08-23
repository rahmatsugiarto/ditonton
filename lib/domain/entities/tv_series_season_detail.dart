import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TvSeriesSeasonDetail extends Equatable {
  TvSeriesSeasonDetail({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonsModelId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final String airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int seasonsModelId;
  final String posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        seasonsModelId,
        posterPath,
        seasonNumber,
      ];
}
