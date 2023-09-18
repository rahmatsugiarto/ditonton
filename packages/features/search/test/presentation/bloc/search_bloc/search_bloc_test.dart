import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvSeries])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvSeries mockSearchTvSeries;
  late SearchState searchState;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTvSeries = MockSearchTvSeries();
    searchBloc = SearchBloc(
      searchMovies: mockSearchMovies,
      searchTvSeries: mockSearchTvSeries,
    );
    searchState = SearchState(
      searchState: RequestState.Empty,
      searchMovieResult: [],
      searchTvResult: [],
      message: "",
      filter: ChipsFilter.Movie,
    );
  });

  group("initial state ", () {
    test('initial state should be empty', () {
      expect(
        searchBloc.state,
        searchState,
      );
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

  group("event OnQueryChangedMovie", () {
    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangedMovie(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        searchState.copyWith(signInState: RequestState.Loading),
        searchState.copyWith(
          searchMovieResult: tMovieList,
          signInState: RequestState.Loaded,
        )
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangedMovie(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        searchState.copyWith(signInState: RequestState.Loading),
        searchState.copyWith(
          message: "Server Failure",
          signInState: RequestState.Error,
        )
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
  group("event OnQueryChangedTv", () {
    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangedTv(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        searchState.copyWith(signInState: RequestState.Loading),
        searchState.copyWith(
          searchTvResult: tTvSeriesList,
          signInState: RequestState.Loaded,
        )
      ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangedTv(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        searchState.copyWith(signInState: RequestState.Loading),
        searchState.copyWith(
          message: "Server Failure",
          signInState: RequestState.Error,
        )
      ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      },
    );
  });

  group("event FilterSearch", () {
    blocTest(
      "set SearchState.filter to ChipsFilter.Movie",
      build: () => searchBloc,
      act: (bloc) => bloc.add(FilterSearch(ChipsFilter.Movie)),
      expect: () => [
        searchState.copyWith(filter: ChipsFilter.Movie),
      ],
    );

    blocTest(
      "set SearchState.filter to ChipsFilter.TvSeries",
      build: () => searchBloc,
      act: (bloc) => bloc.add(FilterSearch(ChipsFilter.TvSeries)),
      expect: () => [
        searchState.copyWith(filter: ChipsFilter.TvSeries),
      ],
    );
  });
}
