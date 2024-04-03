import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/state/view_data_state.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:tv/presentation/bloc/tv_series_list_bloc/tv_series_list_event.dart';
import 'package:tv/tv.dart';

import 'tv_series_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
])
void main() {
  late TvSeriesListBloc tvSeriesListBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TvSeriesListState tvSeriesListState;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesListBloc = TvSeriesListBloc(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    );
    tvSeriesListState = TvSeriesListState(
      nowPlayingTvState: ViewData.initial(),
      popularTvState: ViewData.initial(),
      topRatedTvState: ViewData.initial(),
    );
  });

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
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group("initial state", () {
    test('should have the default value in the init state', () {
      expect(
        tvSeriesListBloc.state,
        tvSeriesListState,
      );
    });
  });

  group("event FetchNowPlayingTvSeries", () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesListState.copyWith(nowPlayingTvState: ViewData.loading()),
        tvSeriesListState.copyWith(
          nowPlayingTvState: ViewData.loaded(
            data: tTvSeriesList,
          ),
        )
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'Should emit [Loading, Error] when get movie recommendations is unsuccessful',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesListState.copyWith(nowPlayingTvState: ViewData.loading()),
        tvSeriesListState.copyWith(
          nowPlayingTvState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );
  });

  group("event FetchPopularTvSeries", () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesListState.copyWith(popularTvState: ViewData.loading()),
        tvSeriesListState.copyWith(
          popularTvState: ViewData.loaded(
            data: tTvSeriesList,
          ),
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'Should emit [Loading, Error] when get movie recommendations is unsuccessful',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesListState.copyWith(popularTvState: ViewData.loading()),
        tvSeriesListState.copyWith(
          popularTvState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });

  group("event FetchTopRatedTvSeries", () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesListState.copyWith(topRatedTvState: ViewData.loading()),
        tvSeriesListState.copyWith(
          topRatedTvState: ViewData.loaded(
            data: tTvSeriesList,
          ),
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'Should emit [Loading, Error] when get movie recommendations is unsuccessful',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvSeriesListState.copyWith(topRatedTvState: ViewData.loading()),
        tvSeriesListState.copyWith(
          topRatedTvState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });
}
