import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SaveWatchlistTvSeries(mockRepository);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(mockRepository.saveWatchlistTvSeries(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockRepository.saveWatchlistTvSeries(testTvSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
