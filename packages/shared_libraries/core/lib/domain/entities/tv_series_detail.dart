import 'package:equatable/equatable.dart';

import 'genre.dart';
import 'tv_series_seasons.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    this.adult = false,
    this.backdropPath = "",
    this.episodeRunTime = const <int>[],
    this.firstAirDate = "",
    this.genres = const <Genre>[],
    this.homepage = "",
    this.id = 0,
    this.inProduction = false,
    this.languages = const <String>[],
    this.lastAirDate = "",
    this.name = "",
    this.numberOfEpisodes = 0,
    this.numberOfSeasons = 0,
    this.originCountry = const <String>[],
    this.originalLanguage = "",
    this.originalName = "",
    this.overview = "",
    this.popularity = 0,
    this.posterPath = "",
    this.seasons = const <TvSeriesSeasons>[],
    this.status = "",
    this.tagline = "",
    this.type = "",
    this.voteAverage = 0,
    this.voteCount = 0,
  });

  final bool adult;
  final String backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<TvSeriesSeasons> seasons;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

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
