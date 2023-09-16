import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/core_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesDetailResponse = TvSeriesDetailResponse(
    adult: false,
    backdropPath: "/6UH52Fmau8RPsMAbQbjwN3wJSCj.jpg",
    episodeRunTime: [45],
    firstAirDate: "2021-03-25",
    genres: [
      GenreModel(
        id: 16,
        name: "Animation",
      ),
    ],
    homepage: "https://www.amazon.com/dp/B08WJP55PR",
    id: 95557,
    inProduction: true,
    languages: ["en"],
    lastAirDate: "2021-04-29",
    name: "Invincible",
    numberOfEpisodes: 12,
    numberOfSeasons: 2,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Invincible",
    overview:
        "Mark Grayson is a normal teenager except for the fact that his father is the most powerful superhero on the planet. Shortly after his seventeenth birthday, Mark begins to develop powers of his own and enters into his father’s tutelage.",
    popularity: 68.151,
    posterPath: "/yDWJYRAwMNKbIYT8ZB33qy84uzO.jpg",
    seasons: [
      TvSeriesSeasonModel(
        airDate: "2023-07-21",
        episodeCount: 1,
        id: 349664,
        name: 'Specials',
        overview: '',
        posterPath: '/rJcVipFPY6JdFaDPan10f0OhbpM.jpg',
        seasonNumber: 0,
        voteAverage: 0.0,
      )
    ],
    status: "Returning Series",
    tagline: "Almost there.",
    type: "Scripted",
    voteAverage: 8.694,
    voteCount: 3562,
  );

  final tTvSeries = TvSeriesDetail(
    adult: false,
    backdropPath: "/6UH52Fmau8RPsMAbQbjwN3wJSCj.jpg",
    episodeRunTime: [45],
    firstAirDate: "2021-03-25",
    genres: [
      Genre(
        id: 16,
        name: "Animation",
      ),
    ],
    homepage: "https://www.amazon.com/dp/B08WJP55PR",
    id: 95557,
    inProduction: true,
    languages: ["en"],
    lastAirDate: "2021-04-29",
    name: "Invincible",
    numberOfEpisodes: 12,
    numberOfSeasons: 2,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Invincible",
    overview:
        "Mark Grayson is a normal teenager except for the fact that his father is the most powerful superhero on the planet. Shortly after his seventeenth birthday, Mark begins to develop powers of his own and enters into his father’s tutelage.",
    popularity: 68.151,
    posterPath: "/yDWJYRAwMNKbIYT8ZB33qy84uzO.jpg",
    seasons: [
      TvSeriesSeasons(
        airDate: "2023-07-21",
        episodeCount: 1,
        id: 349664,
        name: 'Specials',
        overview: '',
        posterPath: '/rJcVipFPY6JdFaDPan10f0OhbpM.jpg',
        seasonNumber: 0,
        voteAverage: 0.0,
      )
    ],
    status: "Returning Series",
    tagline: "Almost there.",
    type: "Scripted",
    voteAverage: 8.694,
    voteCount: 3562,
  );

  test('should be a subclass of TvSeriesDetail entity', () async {
    final result = tTvSeriesDetailResponse.toEntity();
    expect(result, tTvSeries);
  });

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_series_detail.json'));
    // act
    final result = TvSeriesDetailResponse.fromJson(jsonMap);
    // assert
    expect(result, tTvSeriesDetailResponse);
  });
}
