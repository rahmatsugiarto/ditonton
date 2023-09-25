import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/dartz/dartz.dart';
import 'package:tv/presentation/bloc/top_rated_tv_series_bloc/top_rated_tv_series_event.dart';
import 'package:tv/tv.dart';

import '../../provider/top_rated_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late TopRatedTvSeriesState topRatedTvSeriesState;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    );
    topRatedTvSeriesState = TopRatedTvSeriesState(
      topRatedTvSeriesState: ViewData.initial(),
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
        topRatedTvSeriesBloc.state,
        topRatedTvSeriesState,
      );
    });
  });

  group("event FetchTopRatedMovies", () {
    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        topRatedTvSeriesState.copyWith(
            topRatedTvSeriesState: ViewData.loading()),
        topRatedTvSeriesState.copyWith(
          topRatedTvSeriesState: ViewData.loaded(
            data: tTvSeriesList,
          ),
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'Should emit [Loading, Error] when get movie recommendations is unsuccessful',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        topRatedTvSeriesState.copyWith(
            topRatedTvSeriesState: ViewData.loading()),
        topRatedTvSeriesState.copyWith(
          topRatedTvSeriesState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });
}
