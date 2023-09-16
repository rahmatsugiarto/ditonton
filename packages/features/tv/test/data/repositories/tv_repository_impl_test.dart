import 'dart:io';

import 'package:core/core.dart';
import 'package:core/core_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl tvRepository;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    mockTvLocalDataSource = MockTvLocalDataSource();
    tvRepository = TvRepositoryImpl(
      remoteDataSource: mockTvRemoteDataSource,
      localDataSource: mockTvLocalDataSource,
    );
  });

  final tTvSeriesModel = TvSeriesModel(
    backdropPath: "/84XPpjGvxNyExjSuLQe0SzioErt.jpg",
    firstAirDate: "2008-01-20",
    genreIds: [
      18,
      80,
    ],
    id: 1396,
    name: "Breaking Bad",
    originCountry: [
      "US",
    ],
    originalLanguage: "en",
    originalName: "Breaking Bad",
    overview:
        "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
    popularity: 239.624,
    posterPath: "/ggFHVNu6YYI5L9pCfOacjizRGt.jpg",
    voteAverage: 8.9,
    voteCount: 12003,
  );

  final tTvSeries = TvSeries(
    backdropPath: "/84XPpjGvxNyExjSuLQe0SzioErt.jpg",
    firstAirDate: "2008-01-20",
    genreIds: [
      18,
      80,
    ],
    id: 1396,
    name: "Breaking Bad",
    originCountry: [
      "US",
    ],
    originalLanguage: "en",
    originalName: "Breaking Bad",
    overview:
        "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
    popularity: 239.624,
    posterPath: "/ggFHVNu6YYI5L9pCfOacjizRGt.jpg",
    voteAverage: 8.9,
    voteCount: 12003,
  );

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await tvRepository.getNowPlayingTvSeries();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTvSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await tvRepository.getNowPlayingTvSeries();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTvSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getNowPlayingTvSeries();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await tvRepository.getPopularTvSeries();
      // assert
      verify(mockTvRemoteDataSource.getPopularTvSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await tvRepository.getPopularTvSeries();
      // assert
      verify(mockTvRemoteDataSource.getPopularTvSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getPopularTvSeries();
      // assert
      verify(mockTvRemoteDataSource.getPopularTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Top Rated Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await tvRepository.getTopRatedTvSeries();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTvSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await tvRepository.getTopRatedTvSeries();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTvSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getTopRatedTvSeries();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Detail', () {
    final tId = 1;
    final tTvSeriesResponse = TvSeriesDetailResponse(
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

    test(
        'should return Tv Series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => tTvSeriesResponse);
      // act
      final result = await tvRepository.getTvSeriesDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Right(testTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await tvRepository.getTvSeriesDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getTvSeriesDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => tTvSeriesList);
      // act
      final result = await tvRepository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await tvRepository.getTvSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockTvRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('save watchlist tv series', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvLocalDataSource.insertWatchlistTvSeries(
        TvSeriesTable.fromEntity(testTvSeriesDetail),
      )).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result =
          await tvRepository.saveWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTvLocalDataSource.insertWatchlistTvSeries(
        TvSeriesTable.fromEntity(testTvSeriesDetail),
      )).thenThrow(DatabaseExp('Failed to add watchlist'));
      // act
      final result =
          await tvRepository.saveWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });
  group('remove watchlist tv series', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvLocalDataSource.removeWatchlistTvSeries(
        TvSeriesTable.fromEntity(testTvSeriesDetail),
      )).thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result =
          await tvRepository.removeWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTvLocalDataSource.removeWatchlistTvSeries(
        TvSeriesTable.fromEntity(testTvSeriesDetail),
      )).thenThrow(DatabaseExp('Failed to remove watchlist'));
      // act
      final result =
          await tvRepository.removeWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist tv series status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockTvLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await tvRepository.isAddedToWatchlistTvSeries(tId);
      // assert
      expect(result, false);
    });
  });

  group('Season Detail Tv Series', () {
    final tId = 1;
    final tSeason = 1;

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
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeason))
          .thenAnswer((_) async => tTvSeriesSeasonDetailResponse);
      // act
      final result = await tvRepository.getTvSeriesSeasonDetail(tId, tSeason);
      // assert
      verify(mockTvRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeason));
      expect(result, Right(tTvSeriesSeasonDetail));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeason))
          .thenThrow(ServerException());
      // act
      final result = await tvRepository.getTvSeriesSeasonDetail(tId, tSeason);
      // assert
      verify(mockTvRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeason));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeason))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getTvSeriesSeasonDetail(tId, tSeason);
      // assert
      verify(mockTvRemoteDataSource.getTvSeriesSeasonDetail(tId, tSeason));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
