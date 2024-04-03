import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/core_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_dependencies/dartz/dartz.dart';
import 'package:tv/presentation/bloc/episode_tv_series_bloc/episode_tv_series_event.dart';
import 'package:tv/tv.dart';

import 'episode_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesSeasonDetail,
])
void main() {
  late EpisodeTvSeriesBloc episodeTvSeriesBloc;
  late MockGetTvSeriesSeasonDetail mockGetTvSeriesSeasonDetail;
  late EpisodeTvSeriesState episodeTvSeriesState;

  setUp(() {
    mockGetTvSeriesSeasonDetail = MockGetTvSeriesSeasonDetail();
    episodeTvSeriesBloc = EpisodeTvSeriesBloc(
      getTvSeriesSeasonDetail: mockGetTvSeriesSeasonDetail,
    );
    episodeTvSeriesState = EpisodeTvSeriesState(
      episodeTvSeriesState: ViewData.initial(),
    );
  });

  final id = 1;
  final seasonNumber = 1;

  group("initial state", () {
    test('should have the default value in the init state', () {
      expect(
        episodeTvSeriesBloc.state,
        episodeTvSeriesState,
      );
    });
  });

  group("event FetchEpisodeTvSeries", () {
    blocTest<EpisodeTvSeriesBloc, EpisodeTvSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesSeasonDetail.execute(id, seasonNumber))
            .thenAnswer((_) async => Right(tTvSeriesSeasonDetail));
        return episodeTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchEpisodeTvSeries(
        id: id,
        season: seasonNumber,
      )),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        episodeTvSeriesState.copyWith(episodeTvSeriesState: ViewData.loading()),
        episodeTvSeriesState.copyWith(
          episodeTvSeriesState: ViewData.loaded(
            data: tTvSeriesSeasonDetail.episodes,
          ),
        )
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesSeasonDetail.execute(id, seasonNumber));
      },
    );

    blocTest<EpisodeTvSeriesBloc, EpisodeTvSeriesState>(
      'Should emit [Loading, Error] when get movie recommendations is unsuccessful',
      build: () {
        when(mockGetTvSeriesSeasonDetail.execute(id, seasonNumber))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return episodeTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchEpisodeTvSeries(
        id: id,
        season: seasonNumber,
      )),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        episodeTvSeriesState.copyWith(episodeTvSeriesState: ViewData.loading()),
        episodeTvSeriesState.copyWith(
          episodeTvSeriesState: ViewData.error(message: "Server Failure"),
        )
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesSeasonDetail.execute(id, seasonNumber));
      },
    );
  });
}
