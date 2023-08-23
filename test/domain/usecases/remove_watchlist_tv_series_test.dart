import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = RemoveWatchlistTvSeries(mockRepository);
  });

  test('should remove watchlist tv series from repository', () async {
    // arrange
    when(mockRepository.removeWatchlistTvSeries(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockRepository.removeWatchlistTvSeries(testTvSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
