import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/core_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/dartz/dartz.dart';
import 'package:watchlist/watchlist.dart';

import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchlistTvSeries,
])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late WatchlistState watchlistState;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistBloc = WatchlistBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
    );
    watchlistState = WatchlistState(
      watchlistMovieState: ViewData.initial(),
      watchlistTvState: ViewData.initial(),
    );
  });

  group("initial state", () {
    test('should have the default value in the init state', () {
      expect(
        watchlistBloc.state,
        watchlistState,
      );
    });
  });

  group("event FetchWatchlistMovies", () {
    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        watchlistState.copyWith(watchlistMovieState: ViewData.loading()),
        watchlistState.copyWith(
          watchlistMovieState: ViewData.loaded(
            data: testMovieList,
          ),
        )
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [Loading, Error] when get movie recommendations is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        watchlistState.copyWith(watchlistMovieState: ViewData.loading()),
        watchlistState.copyWith(
          watchlistMovieState: ViewData.error(message: "Database Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });

  group("event FetchWatchlistTv", () {
    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        watchlistState.copyWith(watchlistTvState: ViewData.loading()),
        watchlistState.copyWith(
          watchlistTvState: ViewData.loaded(
            data: testTvSeriesList,
          ),
        )
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [Loading, Error] when get tv series recommendations is unsuccessful',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        watchlistState.copyWith(watchlistTvState: ViewData.loading()),
        watchlistState.copyWith(
          watchlistTvState: ViewData.error(message: "Database Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );
  });
}
