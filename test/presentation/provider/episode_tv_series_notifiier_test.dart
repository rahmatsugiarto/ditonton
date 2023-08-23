import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/enum.dart';
import 'package:ditonton/domain/usecases/get_tv_series_season_detail.dart';
import 'package:ditonton/presentation/provider/episode_tv_series_notifiier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'episode_tv_series_notifiier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesSeasonDetail,
])
void main() {
  late EpisodeTvSeriesNotifier provider;
  late MockGetTvSeriesSeasonDetail mockGetTvSeriesSeasonDetail;

  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesSeasonDetail = MockGetTvSeriesSeasonDetail();
    provider = EpisodeTvSeriesNotifier(
      getTvSeriesSeasonDetail: mockGetTvSeriesSeasonDetail,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final id = 1;
  final seasonNumber = 1;

  group('fetch tv series season detail', () {
    test('initialState should be Empty', () {
      expect(provider.tvSeriesSeasonState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(
        mockGetTvSeriesSeasonDetail.execute(id, seasonNumber),
      ).thenAnswer((_) async => Right(tTvSeriesSeasonDetail));
      // act
      provider.fetchTvSeriesSeasonDetail(id, seasonNumber);
      // assert
      verify(
        mockGetTvSeriesSeasonDetail.execute(id, seasonNumber),
      );
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(
        mockGetTvSeriesSeasonDetail.execute(id, seasonNumber),
      ).thenAnswer((_) async => Right(tTvSeriesSeasonDetail));
      // act
      provider.fetchTvSeriesSeasonDetail(id, seasonNumber);
      // assert
      expect(provider.tvSeriesSeasonState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(
        mockGetTvSeriesSeasonDetail.execute(id, seasonNumber),
      ).thenAnswer((_) async => Right(tTvSeriesSeasonDetail));
      // act
      await provider.fetchTvSeriesSeasonDetail(id, seasonNumber);
      // assert
      expect(provider.tvSeriesSeasonState, RequestState.Loaded);
      expect(provider.tvSeriesSeason, tTvSeriesSeasonDetail);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(
        mockGetTvSeriesSeasonDetail.execute(id, seasonNumber),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeriesSeasonDetail(id, seasonNumber);
      // assert
      expect(provider.tvSeriesSeasonState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
