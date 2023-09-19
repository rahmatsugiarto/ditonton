import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Movie extends Equatable {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Movie({
    this.adult = false,
    this.backdropPath = "",
    this.genreIds = const [],
    this.id = 0,
    this.originalTitle = "",
    this.overview = "",
    this.popularity = 0,
    this.posterPath = "",
    this.releaseDate = "",
    this.title = "",
    this.video = false,
    this.voteAverage = 0,
    this.voteCount = 0,
  });

  Movie.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
