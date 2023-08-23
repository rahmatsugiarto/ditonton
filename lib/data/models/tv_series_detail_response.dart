import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_series_seasons_model.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_series_detail.dart';

class TvSeriesDetailResponse extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<GenreModel> genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final String? name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<TvSeriesSeasonModel> seasons;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  TvSeriesDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        seasons: List<TvSeriesSeasonModel>.from(
            json["seasons"].map((x) => TvSeriesSeasonModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      adult: this.adult ?? false,
      backdropPath: this.backdropPath ?? "",
      episodeRunTime: this.episodeRunTime ?? <int>[],
      firstAirDate: this.firstAirDate ?? "",
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      homepage: this.homepage ?? "",
      id: this.id ?? 0,
      inProduction: this.inProduction ?? false,
      languages: this.languages ?? <String>[],
      lastAirDate: this.lastAirDate ?? "",
      name: this.name ?? "",
      numberOfEpisodes: this.numberOfEpisodes ?? 0,
      numberOfSeasons: this.numberOfSeasons ?? 0,
      originCountry: this.originCountry ?? <String>[],
      originalLanguage: this.originalLanguage ?? "",
      originalName: this.originalName ?? "",
      overview: this.overview ?? "",
      popularity: this.popularity ?? 0.0,
      posterPath: this.posterPath ?? "",
      seasons: this.seasons.map((genre) => genre.toEntity()).toList(),
      status: this.status ?? "",
      tagline: this.tagline ?? "",
      type: this.type ?? "",
      voteAverage: this.voteAverage ?? 0,
      voteCount: this.voteCount ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
