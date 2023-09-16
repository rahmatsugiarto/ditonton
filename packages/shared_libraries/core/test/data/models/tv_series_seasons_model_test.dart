import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/core_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesSeasonModel = TvSeriesSeasonModel(
    airDate: "2023-07-21",
    episodeCount: 1,
    id: 349664,
    name: "Specials",
    overview: "",
    posterPath: "/rJcVipFPY6JdFaDPan10f0OhbpM.jpg",
    seasonNumber: 0,
    voteAverage: 0.0,
  );

  final tTvSeriesSeasons = TvSeriesSeasons(
    airDate: "2023-07-21",
    episodeCount: 1,
    id: 349664,
    name: "Specials",
    overview: "",
    posterPath: "/rJcVipFPY6JdFaDPan10f0OhbpM.jpg",
    seasonNumber: 0,
    voteAverage: 0.0,
  );

  test('should be a subclass of TvSeriesDetail entity', () async {
    final result = tTvSeriesSeasonModel.toEntity();
    expect(result, tTvSeriesSeasons);
  });

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_series_season.json'));
    // act
    final result = TvSeriesSeasonModel.fromJson(jsonMap);
    // assert
    expect(result, tTvSeriesSeasonModel);
  });
}
