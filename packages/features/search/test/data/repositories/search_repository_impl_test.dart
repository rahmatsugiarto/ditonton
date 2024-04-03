import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchRepositoryImpl searchRepository;
  late MockSearchRemoteDataSource mockSearchRemoteDataSource;

  setUp(() {
    mockSearchRemoteDataSource = MockSearchRemoteDataSource();
    searchRepository = SearchRepositoryImpl(
      remoteDataSource: mockSearchRemoteDataSource,
    );
  });

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

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

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];
  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Seach Movies', () {
    final tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockSearchRemoteDataSource.searchMovies(tQuery))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await searchRepository.searchMovies(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockSearchRemoteDataSource.searchMovies(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await searchRepository.searchMovies(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockSearchRemoteDataSource.searchMovies(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await searchRepository.searchMovies(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Seach Tv Series', () {
    final tQuery = 'spiderman';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockSearchRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await searchRepository.searchTvSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockSearchRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await searchRepository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockSearchRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await searchRepository.searchTvSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
}
