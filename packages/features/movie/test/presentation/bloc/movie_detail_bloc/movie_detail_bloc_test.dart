import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/testing/dummy_data/dummy_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:shared_dependencies/dartz/dartz.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatusMovies,
  SaveWatchlistMovies,
  RemoveWatchlistMovies,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatusMovies mockGetWatchListStatusMovies;
  late MockSaveWatchlistMovies mockSaveWatchlistMovies;
  late MockRemoveWatchlistMovies mockRemoveWatchlistMovies;
  late MovieDetailState movieDetailState;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatusMovies = MockGetWatchListStatusMovies();
    mockSaveWatchlistMovies = MockSaveWatchlistMovies();
    mockRemoveWatchlistMovies = MockRemoveWatchlistMovies();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatusMovies,
      saveWatchlist: mockSaveWatchlistMovies,
      removeWatchlist: mockRemoveWatchlistMovies,
    );
    movieDetailState = MovieDetailState(
      movieState: ViewData.initial(),
      movieRecommendationsState: ViewData.initial(),
      isAddedToWatchlist: false,
      watchlistMessage: "",
      isErrorWatchlist: false,
    );
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  group("initial state", () {
    test('should have the default value in the init state', () {
      expect(
        movieDetailBloc.state,
        movieDetailState,
      );
    });
  });

  group("event FetchMovieDetail", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailState.copyWith(movieState: ViewData.loading()),
        movieDetailState.copyWith(
          movieState: ViewData.loaded(data: testMovieDetail),
        )
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when get movie detail is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailState.copyWith(movieState: ViewData.loading()),
        movieDetailState.copyWith(
          movieState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group("event FetchMovieRecommendation", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieRecommendation(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailState.copyWith(
            movieRecommendationsState: ViewData.loading()),
        movieDetailState.copyWith(
          movieRecommendationsState: ViewData.loaded(data: tMovies),
        )
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when get movie recommendations is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieRecommendation(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailState.copyWith(
            movieRecommendationsState: ViewData.loading()),
        movieDetailState.copyWith(
          movieRecommendationsState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group("event LoadWatchlistStatus", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit isAddedToWatchlist is true when movie already saved',
      build: () {
        when(mockGetWatchListStatusMovies.execute(tId))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [movieDetailState.copyWith(isAddedToWatchlist: true)],
      verify: (bloc) {
        verify(mockGetWatchListStatusMovies.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit isAddedToWatchlist is false when movie has not been saved',
      build: () {
        when(mockGetWatchListStatusMovies.execute(tId))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [movieDetailState.copyWith(isAddedToWatchlist: false)],
      verify: (bloc) {
        verify(mockGetWatchListStatusMovies.execute(tId));
      },
    );
  });

  group("event AddWatchlist", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit watchlistMessage with success message and isErrorWatchlist is false when save watchlist successfully',
      build: () {
        when(mockSaveWatchlistMovies.execute(testMovieDetail))
            .thenAnswer((_) async => Right("Added to Watchlist"));
        when(mockGetWatchListStatusMovies.execute(tId))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(movie: testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailState.copyWith(
          watchlistMessage: "Added to Watchlist",
          isErrorWatchlist: false,
          isAddedToWatchlist: true,
        )
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovies.execute(testMovieDetail));
        verify(mockGetWatchListStatusMovies.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit watchlistMessage with failure message and isErrorWatchlist is true when save watchlist unsuccessful',
      build: () {
        when(mockSaveWatchlistMovies.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        when(mockGetWatchListStatusMovies.execute(tId))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(movie: testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailState.copyWith(
          watchlistMessage: 'Database Failure',
          isErrorWatchlist: true,
          isAddedToWatchlist: false,
        )
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovies.execute(testMovieDetail));
        verify(mockGetWatchListStatusMovies.execute(tId));
      },
    );
    test("should emit isAddedToWatchlist is true when movie already saved",
        () async {
      // arrange
      when(mockGetWatchListStatusMovies.execute(tId))
          .thenAnswer((_) async => true);
      // act
      final result = await movieDetailBloc.getWatchListStatus.execute(tId);
      // assert
      expect(result, true);
    });

    test(
        "should emit isAddedToWatchlist false when the movie has not been saved",
        () async {
      // arrange
      when(mockGetWatchListStatusMovies.execute(tId))
          .thenAnswer((_) async => false);
      // act
      final result = await movieDetailBloc.getWatchListStatus.execute(tId);
      // assert
      expect(result, false);
    });
  });

  group("event RemoveFromWatchlist", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit watchlistMessage with success message and isErrorWatchlist is false when remove watchlist successfully',
      build: () {
        when(mockRemoveWatchlistMovies.execute(testMovieDetail))
            .thenAnswer((_) async => Right("Removed from Watchlist"));
        when(mockGetWatchListStatusMovies.execute(tId))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(movie: testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailState.copyWith(
          watchlistMessage: "Removed from Watchlist",
          isErrorWatchlist: false,
          isAddedToWatchlist: true,
        )
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovies.execute(testMovieDetail));
        verify(mockGetWatchListStatusMovies.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit watchlistMessage with failure message and isErrorWatchlist is true when remove watchlist unsuccessful',
      build: () {
        when(mockRemoveWatchlistMovies.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        when(mockGetWatchListStatusMovies.execute(tId))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(movie: testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailState.copyWith(
          watchlistMessage: 'Database Failure',
          isErrorWatchlist: true,
          isAddedToWatchlist: false,
        )
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovies.execute(testMovieDetail));
        verify(mockGetWatchListStatusMovies.execute(tId));
      },
    );

    test("should emit isAddedToWatchlist is true when movie already saved",
        () async {
      // arrange
      when(mockGetWatchListStatusMovies.execute(tId))
          .thenAnswer((_) async => true);
      // act
      final result = await movieDetailBloc.getWatchListStatus.execute(tId);
      // assert
      expect(result, true);
    });

    test(
        "should emit isAddedToWatchlist false when the movie has not been saved",
        () async {
      // arrange
      when(mockGetWatchListStatusMovies.execute(tId))
          .thenAnswer((_) async => false);
      // act
      final result = await movieDetailBloc.getWatchListStatus.execute(tId);
      // assert
      expect(result, false);
    });
  });
}
