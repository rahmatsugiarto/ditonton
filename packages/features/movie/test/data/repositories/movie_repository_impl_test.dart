import 'dart:io';

import 'package:core/core.dart';
import 'package:core/core_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl movieRepositoryImpl;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;
  late MockMovieLocalDataSource mockMovieLocalDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    mockMovieLocalDataSource = MockMovieLocalDataSource();
    movieRepositoryImpl = MovieRepositoryImpl(
      remoteDataSource: mockMovieRemoteDataSource,
      localDataSource: mockMovieLocalDataSource,
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

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getNowPlayingMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await movieRepositoryImpl.getNowPlayingMovies();
      // assert
      verify(mockMovieRemoteDataSource.getNowPlayingMovies());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getNowPlayingMovies())
          .thenThrow(ServerException());
      // act
      final result = await movieRepositoryImpl.getNowPlayingMovies();
      // assert
      verify(mockMovieRemoteDataSource.getNowPlayingMovies());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getNowPlayingMovies())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await movieRepositoryImpl.getNowPlayingMovies();
      // assert
      verify(mockMovieRemoteDataSource.getNowPlayingMovies());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Movies', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getPopularMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await movieRepositoryImpl.getPopularMovies();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getPopularMovies())
          .thenThrow(ServerException());
      // act
      final result = await movieRepositoryImpl.getPopularMovies();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getPopularMovies())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await movieRepositoryImpl.getPopularMovies();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getTopRatedMovies())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await movieRepositoryImpl.getTopRatedMovies();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getTopRatedMovies())
          .thenThrow(ServerException());
      // act
      final result = await movieRepositoryImpl.getTopRatedMovies();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getTopRatedMovies())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await movieRepositoryImpl.getTopRatedMovies();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieDetail(tId))
          .thenAnswer((_) async => tMovieResponse);
      // act
      final result = await movieRepositoryImpl.getMovieDetail(tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(Right(testMovieDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await movieRepositoryImpl.getMovieDetail(tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await movieRepositoryImpl.getMovieDetail(tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieRecommendations(tId))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await movieRepositoryImpl.getMovieRecommendations(tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await movieRepositoryImpl.getMovieRecommendations(tId);
      // assertbuild runner
      verify(mockMovieRemoteDataSource.getMovieRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await movieRepositoryImpl.getMovieRecommendations(tId);
      // assert
      verify(mockMovieRemoteDataSource.getMovieRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
  group('save watchlist movies', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockMovieLocalDataSource.insertWatchlistMovies(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result =
          await movieRepositoryImpl.saveWatchlistMovies(testMovieDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockMovieLocalDataSource.insertWatchlistMovies(testMovieTable))
          .thenThrow(DatabaseExp('Failed to add watchlist'));
      // act
      final result =
          await movieRepositoryImpl.saveWatchlistMovies(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist movies', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockMovieLocalDataSource.removeWatchlistMovies(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result =
          await movieRepositoryImpl.removeWatchlistMovies(testMovieDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockMovieLocalDataSource.removeWatchlistMovies(testMovieTable))
          .thenThrow(DatabaseExp('Failed to remove watchlist'));
      // act
      final result =
          await movieRepositoryImpl.removeWatchlistMovies(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist movies status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockMovieLocalDataSource.getMovieById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await movieRepositoryImpl.isAddedToWatchlistMovies(tId);
      // assert
      expect(result, false);
    });
  });
}
