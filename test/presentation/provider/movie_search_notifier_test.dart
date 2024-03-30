import 'package:dartz/dartz.dart';
import 'package:ditonton/common/enum.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/provider/search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_notifier_test.mocks.dart';

@GenerateMocks([
  SearchMovies,
  SearchTvSeries,
])
void main() {
  late SearchNotifier provider;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMovies();
    mockSearchTvSeries = MockSearchTvSeries();

    provider = SearchNotifier(
      searchMovies: mockSearchMovies,
      searchTvSeries: mockSearchTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tMovieModel = Movie(
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

  final tTvSeries = TvSeries(
    backdropPath: "/path.jpg",
    firstAirDate: "2023-05-08",
    genreIds: [1, 2, 3],
    id: 1,
    name: "Name",
    originCountry: [
      "BR",
    ],
    originalLanguage: "Original Language",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 9.5,
    posterPath: "/path.jpg",
    voteAverage: 5.7,
    voteCount: 43,
  );

  final tMovieList = <Movie>[tMovieModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  final tQuery = 'spiderman';

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.searchMovieState, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.searchMovieState, RequestState.Loaded);
      expect(provider.searchMovieResult, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.searchMovieState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('search tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.searchMovieState, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.searchMovieState, RequestState.Loaded);
      expect(provider.searchTvResult, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.searchMovieState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group("set filter", () {
    test("should return filter movie", () {
      final filter = ChipsFilter.Movie;
      provider.setFilter(filter);
      expect(provider.filter, ChipsFilter.Movie);
      expect(listenerCallCount, 1);
    });

    test("should return filter tv series", () {
      final filter = ChipsFilter.TvSeries;
      provider.setFilter(filter);
      expect(provider.filter, ChipsFilter.TvSeries);
      expect(listenerCallCount, 1);
    });
  });
}
