import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/core_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesSeasonDetailResponse = TvSeriesSeasonDetailResponse(
    id: "63cafc22ea3949007ca1f2ee",
    airDate: "2023-11-02",
    episodes: [
      EpisodeModel(
        airDate: "2023-11-02",
        episodeNumber: 1,
        name: "Episode 1",
        overview: "",
        id: 4590786,
        productionCode: "",
        seasonNumber: 2,
        stillPath: "stillPath",
        voteAverage: 0.0,
        voteCount: 0,
      ),
    ],
    name: "Season 2",
    overview: "",
    seasonsModelId: 325266,
    posterPath: "/lxVS24ZhG3WQf3IMbkFIg6olT6A.jpg",
    seasonNumber: 2,
  );

  final tTvSeriesSeasonDetail = TvSeriesSeasonDetail(
    id: "63cafc22ea3949007ca1f2ee",
    airDate: "2023-11-02",
    episodes: [
      Episode(
        airDate: "2023-11-02",
        episodeNumber: 1,
        name: "Episode 1",
        overview: "",
        id: 4590786,
        productionCode: "",
        seasonNumber: 2,
        stillPath: "stillPath",
        voteAverage: 0.0,
        voteCount: 0,
      ),
    ],
    name: "Season 2",
    overview: "",
    seasonsModelId: 325266,
    posterPath: "/lxVS24ZhG3WQf3IMbkFIg6olT6A.jpg",
    seasonNumber: 2,
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_season_detail.json'));
      // act
      final result = TvSeriesSeasonDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesSeasonDetailResponse);
    });
  });

  group('toEntity', () {
    test('should be a subclass of TvSeriesSeasonDetail entity', () async {
      final result = tTvSeriesSeasonDetailResponse.toEntity();
      expect(result, tTvSeriesSeasonDetail);
    });
  });
}
