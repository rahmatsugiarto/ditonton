import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/dartz/dartz.dart';
import 'package:tv/presentation/bloc/popular_tv_series_bloc/popular_tv_series_event.dart';
import 'package:tv/tv.dart';

import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late PopularTvSeriesState popularTvSeriesState;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(
      getPopularTvSeries: mockGetPopularTvSeries,
    );
    popularTvSeriesState = PopularTvSeriesState(
      popularTvSeriesState: ViewData.initial(),
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
        popularTvSeriesBloc.state,
        popularTvSeriesState,
      );
    });
  });

  group("event FetchPopularTvSeries", () {
    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        popularTvSeriesState.copyWith(popularTvSeriesState: ViewData.loading()),
        popularTvSeriesState.copyWith(
          popularTvSeriesState: ViewData.loaded(
            data: tTvSeriesList,
          ),
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'Should emit [Loading, Error] when get movie recommendations is unsuccessful',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        popularTvSeriesState.copyWith(popularTvSeriesState: ViewData.loading()),
        popularTvSeriesState.copyWith(
          popularTvSeriesState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });
}
