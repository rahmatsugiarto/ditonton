import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_series_seasons.dart';


class TvSeriesSeasonModel extends Equatable {
  final String? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  TvSeriesSeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory TvSeriesSeasonModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesSeasonModel(
        airDate: json["air_date"],
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"]?.toDouble(),
      );

  TvSeriesSeasons toEntity() {
    return TvSeriesSeasons(
      airDate: this.airDate ?? "",
      episodeCount: this.episodeCount ?? 0,
      id: this.id ?? 0,
      name: this.name ?? "",
      overview: this.overview ?? "",
      posterPath: this.posterPath ?? "",
      seasonNumber: this.seasonNumber ?? 0,
      voteAverage: this.voteAverage ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}
