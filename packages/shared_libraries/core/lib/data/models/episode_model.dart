import 'package:equatable/equatable.dart';

import '../../domain/entities/episode.dart';

class EpisodeModel extends Equatable {
  EpisodeModel({
    required this.airDate,
    required this.episodeNumber,
    required this.name,
    required this.overview,
    required this.id,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? airDate;
  final int? episodeNumber;
  final String? name;
  final String? overview;
  final int? id;
  final String? productionCode;
  final int? seasonNumber;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        name: json["name"],
        overview: json["overview"],
        id: json["id"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Episode toEntity() {
    return Episode(
      airDate: this.airDate ?? '',
      episodeNumber: this.episodeNumber ?? 0,
      name: this.name ?? '',
      overview: this.overview ?? '',
      id: this.id ?? 0,
      productionCode: this.productionCode ?? '',
      seasonNumber: this.seasonNumber ?? 0,
      stillPath: this.stillPath ?? '',
      voteAverage: this.voteAverage ?? 0.0,
      voteCount: this.voteCount ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        name,
        overview,
        id,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
