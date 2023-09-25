import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/testing/dummy_data/dummy_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/dartz/dartz.dart';
import 'package:tv/tv.dart';

import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late TvSeriesDetailState tvSeriesDetailState;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    tvSeriesDetailBloc = TvSeriesDetailBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatus: mockGetWatchListStatusTvSeries,
      saveWatchlist: mockSaveWatchlistTvSeries,
      removeWatchlist: mockRemoveWatchlistTvSeries,
    );
    tvSeriesDetailState = TvSeriesDetailState(
      tvSeriesDetailState: ViewData.initial(),
      tvRecommendationsState: ViewData.initial(),
      isAddedToWatchlist: false,
      watchlistMessage: "",
      isErrorWatchlist: false,
    );
  });

  final tId = 1;

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

  final tListTvSeries = <TvSeries>[tTvSeries];

  group("initial state", () {
    test('should have the default value in the init state', () {
      expect(
        tvSeriesDetailBloc.state,
        tvSeriesDetailState,
      );
    });
  });

  group("event FetchTvSeriesDetail", () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetail(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesDetailState.copyWith(tvSeriesDetailState: ViewData.loading()),
        tvSeriesDetailState.copyWith(
          tvSeriesDetailState: ViewData.loaded(
            data: testTvSeriesDetail,
          ),
        )
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, Error] when get tvSeries recommendations is unsuccessful',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetail(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesDetailState.copyWith(tvSeriesDetailState: ViewData.loading()),
        tvSeriesDetailState.copyWith(
          tvSeriesDetailState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );
  });

  group("event FetchTvSeriesRecommendation", () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tListTvSeries));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesRecommendation(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesDetailState.copyWith(
            tvSeriesRecommendationsState: ViewData.loading()),
        tvSeriesDetailState.copyWith(
          tvSeriesRecommendationsState: ViewData.loaded(
            data: tListTvSeries,
          ),
        )
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit [Loading, Error] when get movie recommendations is unsuccessful',
      build: () {
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesRecommendation(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesDetailState.copyWith(
            tvSeriesRecommendationsState: ViewData.loading()),
        tvSeriesDetailState.copyWith(
          tvSeriesRecommendationsState:
              ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );
  });

  group("event LoadWatchlistStatus", () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit isAddedToWatchlist is true when tv series already saved',
      build: () {
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [tvSeriesDetailState.copyWith(isAddedToWatchlist: true)],
      verify: (bloc) {
        verify(mockGetWatchListStatusTvSeries.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit isAddedToWatchlist is false when tv series has not been saved',
      build: () {
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(id: tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [tvSeriesDetailState.copyWith(isAddedToWatchlist: false)],
      verify: (bloc) {
        verify(mockGetWatchListStatusTvSeries.execute(tId));
      },
    );
  });
  group("event AddWatchlist", () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit watchlistMessage with success message and isErrorWatchlist is false when save watchlist successfully',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right("Added to Watchlist"));
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(tvSeries: testTvSeriesDetail)),
      wait: const Duration(milliseconds: 5000),
      expect: () => [
        tvSeriesDetailState.copyWith(
          watchlistMessage: "Added to Watchlist",
          isErrorWatchlist: false,
          isAddedToWatchlist: true,
        )
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchListStatusTvSeries.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit watchlistMessage with failure message and isErrorWatchlist is true when save watchlist unsuccessful',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(tvSeries: testTvSeriesDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesDetailState.copyWith(
          watchlistMessage: 'Database Failure',
          isErrorWatchlist: true,
          isAddedToWatchlist: false,
        )
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchListStatusTvSeries.execute(tId));
      },
    );
    // test("should emit isAddedToWatchlist is true when tvSeries already saved",
    //     () async {
    //   // arrange
    //   when(mockGetWatchListStatusTvSeries.execute(tId))
    //       .thenAnswer((_) async => true);
    //   // act
    //   final result = await tvSeriesDetailBloc.getWatchListStatus.execute(tId);
    //   // assert
    //   expect(result, true);
    // });

    // test(
    //     "should emit isAddedToWatchlist false when the tvSeries has not been saved",
    //     () async {
    //   // arrange
    //   when(mockGetWatchListStatusTvSeries.execute(tId))
    //       .thenAnswer((_) async => false);
    //   // act
    //   final result = await tvSeriesDetailBloc.getWatchListStatus.execute(tId);
    //   // assert
    //   expect(result, false);
    // });
  });

  group("event RemoveFromWatchlist", () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit watchlistMessage with success message and isErrorWatchlist is false when remove watchlist successfully',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right("Removed from Watchlist"));
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(RemoveFromWatchlist(tvSeries: testTvSeriesDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesDetailState.copyWith(
          watchlistMessage: "Removed from Watchlist",
          isErrorWatchlist: false,
          isAddedToWatchlist: true,
        )
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchListStatusTvSeries.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'Should emit watchlistMessage with failure message and isErrorWatchlist is true when remove watchlist unsuccessful',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        when(mockGetWatchListStatusTvSeries.execute(tId))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(RemoveFromWatchlist(tvSeries: testTvSeriesDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesDetailState.copyWith(
          watchlistMessage: 'Database Failure',
          isErrorWatchlist: true,
          isAddedToWatchlist: false,
        )
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchListStatusTvSeries.execute(tId));
      },
    );

    test("should emit isAddedToWatchlist is true when tvSeries already saved",
        () async {
      // arrange
      when(mockGetWatchListStatusTvSeries.execute(tId))
          .thenAnswer((_) async => true);
      // act
      final result = await tvSeriesDetailBloc.getWatchListStatus.execute(tId);
      // assert
      expect(result, true);
    });

    test(
        "should emit isAddedToWatchlist false when the tvSeries has not been saved",
        () async {
      // arrange
      when(mockGetWatchListStatusTvSeries.execute(tId))
          .thenAnswer((_) async => false);
      // act
      final result = await tvSeriesDetailBloc.getWatchListStatus.execute(tId);
      // assert
      expect(result, false);
    });
  });
}
