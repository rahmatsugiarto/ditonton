import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_series_season_detail.dart';
import 'episode_model.dart';

class TvSeriesSeasonDetailResponse extends Equatable {
  TvSeriesSeasonDetailResponse({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonsModelId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? id;
  final String? airDate;
  final List<EpisodeModel> episodes;
  final String? name;
  final String? overview;
  final int? seasonsModelId;
  final String? posterPath;
  final int? seasonNumber;

  factory TvSeriesSeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesSeasonDetailResponse(
        id: json["_id"],
        airDate: json["air_date"],
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonsModelId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  TvSeriesSeasonDetail toEntity() {
    return TvSeriesSeasonDetail(
      id: this.id ?? '',
      airDate: this.airDate ?? '',
      episodes: this.episodes.map((episode) => episode.toEntity()).toList(),
      name: this.name ?? '',
      overview: this.overview ?? '',
      seasonsModelId: this.seasonsModelId ?? 0,
      posterPath: this.posterPath ?? '',
      seasonNumber: this.seasonNumber ?? 0,
    );
  }

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
