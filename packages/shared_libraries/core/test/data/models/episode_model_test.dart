import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/core_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
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
  );

  final tEpisode = Episode(
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
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/episode.json'));
      // act
      final result = EpisodeModel.fromJson(jsonMap);
      // assert
      expect(result, tEpisodeModel);
    });
  });

  group('toEntity', () {
    test('should be a subclass of Episode entity', () async {
      final result = tEpisodeModel.toEntity();
      expect(result, tEpisode);
    });
  });
}
